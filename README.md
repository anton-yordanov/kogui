# Kogui

Generate HTML using Crystal.

> Heavily inspired in [Clearwater.cr](https://github.com/clearwater-rb/clearwater) Component system.

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
    html lang: "en" do
      [
        head do
          title { "Title" }
        end,

        body style: "width: 100vw" do
          [
            h1 id: "__title", class: "bold__text" do
              h1 style: {"font-size": "2rem"} do
                Array.new(5) do
                  h1 { Time.utc.to_s }
                end
              end
            end,
          ]
        end,
      ]
    end
  end
end

app = App.new
html = app.to_s # <html><head><titl...
```

Result (prettified):
```html
<html lang="en">

<head>
    <title>Title</title>
</head>

<body style="width: 100vw">
    <h1 id="__title" class="bold__text">
        <h1 style="font-size:2rem">
            <h1>2020-04-10 18:18:21 UTC</h1>
            <h1>2020-04-10 18:18:21 UTC</h1>
            <h1>2020-04-10 18:18:21 UTC</h1>
            <h1>2020-04-10 18:18:21 UTC</h1>
            <h1>2020-04-10 18:18:21 UTC</h1>
        </h1>
    </h1>
</body>

</html>
```

## Development

TODO:
- Router system

## Contributing

1. Fork it (<https://github.com/krthr/kogui/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [krthr](https://github.com/krthr) - creator and maintainer
