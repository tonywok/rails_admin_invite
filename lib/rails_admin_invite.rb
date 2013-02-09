require "rails_admin_invite/engine"

module RailsAdminInvite
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class Invite < New
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :visible? do
          #TODO: Don't hard code Admin
          authorized? && bindings[:abstract_model].to_s == "Admin"
        end

        register_instance_option :controller do
          Proc.new do
            if request.get? # NEW
              @object = @abstract_model.new
              @authorization_adapter && @authorization_adapter.attributes_for(:new, @abstract_model).each do |name, value|
                @object.send("#{name}=", value)
              end
              if object_params = params[@abstract_model.to_param]
                @object.set_attributes(@object.attributes.merge(object_params), _attr_accessible_role)
              end
              respond_to do |format|
                format.html { render @action.template_name }
                format.js   { render @action.template_name, :layout => false }
              end
            elsif request.post? # INVITE
              #TODO: find a way to get to AR class from @abstract_model
              @object = Admin.invite!(params[:admin], current_user)
              if @object.errors.empty?
                notice = I18n.t("admin.actions.invite.sent", email: @object.email)
                if params[:return_to]
                  redirect_to(params[:return_to], notice: notice)
                else
                  redirect_to(invite_path(:model_name => @abstract_model.to_param, :id => @object.id), notice: notice)
                end
              else
                handle_save_error
              end
            end
          end
        end

      end
    end
  end
end

