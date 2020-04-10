require "./component/html_tags.cr"
require "./component/tag.cr"

module Kogui
  module Component
    # Override this method to determine what content your component renders
    def render
    end

    {% for name, index in HTML_TAGS %}
      # a virtual-DOM node representing an {{name.id}} element
      def {{name.id}}(attributes : JSON::Any? = nil, content : (Array(Component) | Array(Tag) | String)? = nil) : Tag
        tag "{{name.id}}", attributes, content
      end    

      # a virtual-DOM node representing an {{name.id}} element
      def {{name.id}}(content : (Array(Component) | Array(Tag) | String)) : Tag 
        tag "{{name.id}}", content: content
      end
    {% end %}

    def tag(tag_name : String, attributes : JSON::Any? = nil, content : (Array(Component) | Array(Tag) | String)? = nil) : Tag
      Tag.new(tag_name, attributes, content)
    end

    def attr(attributes : Hash) : JSON::Any
      JSON.parse attributes.to_json
    end

    def to_s : String
      render.to_s
    end
  end
end
