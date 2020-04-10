# Kogui

TODO: Write a description here

> Heavely inspired in [Clearwater.cr](https://github.com/clearwater-rb/clearwater)

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     kogui:
       github: krthr/kogui
   ```

2. Run `shards install`

## Usage

```rb
require "kogui"

class App
  include Kogui::Component

  def render
    html(
      [
        head(
          [
            title("Title"),
          ]
        ),

        body(
          attr({
            :style => "width: 100vw",
          }),
          [
            h1(
              attr({
                :id    => "__title",
                :class => "bold-text",
                :style => {
                  "font-size": "23px",
                },
              }),
              "Hello world!"
            ),
          ]
        ),
      ]
    )
  end
end

app = App.new
html = app.to_s # <html><head><titl...
```

Result (prettified):
```html
<html>
  <head>
    <title>Title</title>
  </head>
  <body>
    <h1 class="bold-text" style="font-size:23px" id="__title" >Hello world!</h1>
  </body>
</html>
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/krthr/kogui/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [krthr](https://github.com/krthr) - creator and maintainer
