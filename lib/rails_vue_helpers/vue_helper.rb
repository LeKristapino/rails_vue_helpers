require 'rails_vue_helpers/vue_component_builder'

module RailsVueHelpers::VueHelper
  def vue_component(component_name, **props, &block)
    RailsVueHelpers::VueComponentBuilder.create(component_name, **props, &block)
  end
end
