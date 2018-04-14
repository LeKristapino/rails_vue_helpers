module RailsVueHelpers::VueHelper
  def vue_component(component_name, **props, &block)
    component_name = component_name.underscore.tr('_', '-')
    raw = props.delete(:raw)
    if block_given?
      "<#{component_name} #{attribute_options(props)} #{raw}>#{capture(&block)}</#{component_name}>".html_safe
    else
      "<#{component_name} #{attribute_options(props)} #{raw}></#{component_name}>".html_safe
    end
  end

  private

  def attribute_options(attributes = {})
    binded_props = attributes.delete(:binded) || {}
    event_props = attributes.delete(:events) || {}
    result_attrs = ''

    attributes.each do |key, value|
      normalized_key = key.to_s.underscore.tr('_', '-')
      normalized_value = value

      if value.is_a?(Array)
        normalized_value = value.to_s.tr('"', '\'')
      elsif value =~ /"/
        normalized_value = value.tr('"', '\'')
      end
      result_attrs += "#{normalized_key}=\"#{normalized_value}\" "
    end

    binded_props.each do |key, value|
      normalized_key = key.to_s.underscore.tr('_', '-')
      normalized_value = value
      unless value.is_a?(String)
        # if there are some single quotes in the text, make them in ASCII
        # so HTML doesn't brake
        normalized_value = value.to_json.gsub("'", "&#39")
      end
      result_attrs += "v-bind:#{normalized_key}='#{normalized_value}' "
    end

    event_props.each do |key, value|
      normalized_key = key.to_s.underscore.tr('_', '-')
      result_attrs += "v-on:#{normalized_key}='#{value}' "
    end
    result_attrs
  end
end
