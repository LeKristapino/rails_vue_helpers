require "rails_vue_helpers/version"
require "rails_vue_helpers/vue_helper"
ActiveSupport.on_load(:action_view) do
  include RailsVueHelpers::VueHelper
end
