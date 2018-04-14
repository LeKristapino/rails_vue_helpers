class RailsVueHelpers::VueComponentBuilder
  include ActionView::Helpers::CaptureHelper
  include ActionView::Context

  def self.create(component_name, **props, &block)
    new(component_name, **props).to_html(&block)
  end

  def initialize(component_name, **props)
    @component_name = component_name
    @props = props
    @raw = @props[:raw]
  end

  def to_html(&block)
    if block_given?
      ActiveSupport::SafeBuffer.new("<#{sanitized_component_name} #{attribute_options(props)} #{raw}>#{capture(&block)}</#{sanitized_component_name}>")
    else
      ActiveSupport::SafeBuffer.new("<#{sanitized_component_name} #{attribute_options(props)} #{raw}></#{sanitized_component_name}>")
    end
  end

  def sanitized_component_name
    ActiveSupport::Inflector.underscore(@component_name.to_s).tr('_', '-')
  end

  private

  def attributes
    [binded_props, event_props, regular_props].flatten.join(' ')
  end

  def binded_props
    binded_props = @props[:binded] || {}
    binded_props.map { |key, value| transpile_binded_prop(key, value) }
  end

  def event_props
    event_props = @props[:events] || {}
    event_props.map { |key, value| transpile_event_prop(key, value) }
  end

  def regular_props
    regular_props = @props.reject { |key, value| [:events, :binded, :raw].include?(key) }
    regular_props.map { |key, value| transpile_regular_prop(key, value) }
  end

  def transpile_regular_prop(key, value)
    normalized_key = key.to_s.underscore.tr('_', '-')
    normalized_value = value

    if value.is_a?(Array)
      normalized_value = value.to_s.tr('"', '\'')
    elsif value =~ /"/
      normalized_value = value.tr('"', '\'')
    end
    "#{normalized_key}=\"#{normalized_value}\" "
  end

  def transpile_binded_prop(key,value)
    normalized_key = ActiveSupport::Inflector.underscore(key.to_s).tr('_', '-')
    normalized_value = value
    unless value.is_a?(String)
      # if there are some single quotes in the text, make them in ASCII
      # so HTML doesn't brake
      normalized_value = value.to_json.gsub("'", "&#39")
    end
    "v-bind:#{normalized_key}='#{normalized_value}'"
  end

  def transpile_event_prop(key, value)
    normalized_key = key.to_s.underscore.tr('_', '-')
    "v-on:#{normalized_key}='#{value}'"
  end
end
