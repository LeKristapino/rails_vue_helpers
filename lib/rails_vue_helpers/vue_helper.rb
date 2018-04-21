module RailsVueHelpers::VueHelper
  def vue_component(component_name, **props, &block)
    RailsVueHelpers::VueComponentBuilder.new(self, component_name, **props).to_html(&block)
  end
end
