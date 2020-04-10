require "./component/html_tags.cr"
require "./component/tag.cr"

module Kogui
  module Component
    # Override this method to determine what content your component renders
    def render
    end

    {% for name, index in HTML_TAGS %}      
      # a virtual-DOM node representing an {{name.id}} element
      def {{name.id}}(**attributes)
        Tag.new "{{name.id}}", attributes, yield
      end

      # a virtual-DOM node representing an {{name.id}} element
      def {{name.id}}
        Tag.new "{{name.id}}", nil, nil
      end
    {% end %}

    def to_s : String
      render.to_s
    end
  end
end
