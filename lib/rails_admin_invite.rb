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
          return false unless authorized?

          invitable_models = Devise.mappings.map do |scope, mapping|
            mapping.class_name if mapping.modules.include?(:invitable)
          end.compact

          invitable_models.include?(bindings[:abstract_model].to_s)
        end

        register_instance_option :controller do
          Proc.new do
            if request.get?
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
            elsif request.post?
              satisfy_strong_params!
              sanitize_params_for!(request.xhr? ? :model : :create)

              @object = @abstract_model.model.invite!(params[@abstract_model.to_param], _current_user)
              if @object.errors.empty?
                notice = I18n.t("admin.actions.invite.sent", email: @object.email)
                if params[:return_to]
                  redirect_to(params[:return_to], notice: notice)
                else
                  redirect_to(invite_path(:model_name => @abstract_model.to_param), notice: notice)
                end
              else
                handle_save_error :whereto => :invite
              end
            end
          end
        end
      end
    end
  end
end

