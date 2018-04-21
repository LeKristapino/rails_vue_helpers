# RailsVueHelpers

This small helper gem allows you to add Vue components to your Rails views with a clean syntax.

Instead of writing
```ruby
<some-component v-on:click='doThis' v-bind:vueParam="<%= @some_instance.to_json %>" />
````
  you can write

```ruby
<%= vue_component('someComponent', events: { click: 'doThis'}, binded: { vue_param: @some_instance}) %>
```

This gem conveniently calls `to_json` on objects, as well as handles cases where parameters include single or double quotes, without screwing up HTML rendering.

All you need to do this wrap everything in a Vue initialized container, and you're good to go.

## Installation

```ruby
gem 'rails_vue_helpers'
```

## Usage

`vue_component('componentName', **args, &block)`

All arguments, except special keys: `binded:`, `events:`, `raw:` are translated in regular camelCased Vue props


### Events

```ruby
<%= vue_component('someComponent', events: { click: 'doThis'} ) %>
```
will result in

```ruby
<some-component v-on:click='doThis'></some-component>
```

### Binded parameters

```ruby
<%= vue_component('someComponent', binded: { some_array: ['a', 'b'], some_boolean: true } ) %>
```
will result in

```ruby
<some-component v-bind:someArray="['a', 'b']", v-bind:someBoolean="true"></some-component>
```

### Directives or custom attributes

```ruby
<%= vue_component('someComponent', raw: 'v-something v-something-else') %>
```
will result in

```ruby
<some-component v-something v-something-else></some-component>
```

### Wrapper

```ruby
<%= vue_component('someWrapperComponent') do %>
  <div>Everything else you need in rails view</div>
  <%= vue_component('someInnerComponent') %>
<% end %>
```
will result in

```ruby
<some-wrapper-component>
  <div>Everything else you need in rails view</div>
  <some-inner-component></some-inner-component>
</some-component>
```


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RailsVueHelpers project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rails_vue_helpers/blob/master/CODE_OF_CONDUCT.md).
