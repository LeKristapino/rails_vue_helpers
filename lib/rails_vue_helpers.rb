require "rails_vue_helpers/version"
# require 'active_support'
# require 'active_support/core_ext/object/blank'
# require 'action_view'
require 'rails_vue_helpers/vue_component_builder'
require "rails_vue_helpers/vue_helper"

ActiveSupport.on_load(:action_view) do
  include RailsVueHelpers::VueHelper
end
