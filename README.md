# THIS REPOSITORY IS NOT MAINTAINED

# RailsAdminInvite

This gem is for use with RailsAdmin and Devise Invitable. I wanted to be able to invite Admin
from the Rails Admin backend, having them confirm their account on the app's front end. This is
a quick and dirty way to accomplish that.

It will add an "Invite <model name>" tab on the collection view of a Rails Admin resource that
is configured to use Devise Invitable.

## Installation

Add the following to your `Gemfile`

```ruby
gem 'rails_admin_invite', :git => 'git@github.com:tonywok/rails_admin_invite.git'
```

## TODO

- Look into RailsAdmin I18n convention

