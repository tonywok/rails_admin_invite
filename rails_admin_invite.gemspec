$:.push File.expand_path("../lib", __FILE__)

require "rails_admin_invite/version"

Gem::Specification.new do |s|
  s.name        = "rails_admin_invite"
  s.version     = RailsAdminInvite::VERSION
  s.authors     = ["Tony Schneider"]
  s.email       = ["tonywok@gmail.com"]
  s.homepage    = "http://github.com/tonywok/rails_admin_invite"
  s.summary     = "A custom rails_admin invitation action for use with devise_invitable"
  s.description = "A custom rails_admin invitation action for use with devise_invitable"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_development_dependency "rails", "~> 3.2.11"
  s.add_development_dependency "rails_admin", "~> 0.4.0"
  s.add_development_dependency "devise_invitable", "~> 1.0"
end
