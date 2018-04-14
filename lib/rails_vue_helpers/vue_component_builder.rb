class RailsVueHelpers::VueComponentBuilder
  def self.create(component_name, **props, &block)
    self.class.new(component_name, **props).to_html(&block)
  end

  def initialize(component_name, **props)
    @component_name = component_name
    @props = props
    @raw = @props[:raw]
  end

  def to_html(&block)
    "<#{sanitized_component_name} #{attributes} #{@raw}>#{capture(&block) if block_given?}</#{sanitized_component_name}>".html_safe
  end

  def sanitized_component_name
    @component_name.to_s.underscore.tr('_', '-')
  end

  private

  def attributes
    [binded_props, event_props, regular_props].join(' ')
  end

  def binded_props
    binded_props = @props[:binded] || {}
    binded_props.map { |key, value| transpile_binded_prop(key, value) }.join(' ')
  end

  def event_props
    event_props = @props[:events] || {}
    event_props.map { |key, value| transpile_event_prop(key, value) }.join(' ')
  end

  def regular_props
    regular_props = @props.reject { |key, value| [:events, :binded, :raw].include?(key) }
    regular_props.map { |key, value| transpile_regular_prop(key, value) }.join(' ')
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
    normalized_key = key.to_s.underscore.tr('_', '-')
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
