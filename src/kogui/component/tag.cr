require "json"

module Kogui

  # :nodoc:
  class Tag
    @attributes : Hash(String, String)?

    def initialize(tag_name : String, attributes : JSON::Any?, content : (Array(Component) | Array(Tag) | String)?)
      @tag_name = tag_name
      @attributes = sanitize_attributes(attributes)
      @content = content
    end

    def sanitize_attributes(attributes : JSON::Any?) : Hash(String, String)?
      return nil if attributes.nil?

      attributes_hash = attributes.as_h?
      final_attributes = {} of String => String

      if attributes_hash.is_a? Hash
        if attributes_hash["class_name"]? || attributes_hash["className"]?
          class_name = attributes_hash.delete("class_name") || attributes_hash.delete("className")

          final_attributes["class"] = attributes_hash["class"]? ? attributes_hash["class"].to_s : class_name.to_s
        end

        if attributes_hash["style"]?
          style_hash = attributes_hash["style"].as_h?

          final_attributes["style"] = style_hash
            .map { |(a, v)| "#{a.tr "_", "-"}:#{v}" }
            .join ";" if style_hash.is_a? Hash
        end

        attributes_hash
          .reject { |key, handler|
            key[0, 2] == "on" ||
              ["style", "class_name", "className"].any?(key)
          }
          .each { |(a, v)| final_attributes[a] = v.to_s }
      end

      final_attributes
    end

    def sanitize_content(content) : String
      case content
      when Array
        content.as(Array(Tag)).map { |c| sanitize_content c }.join
      when String
        content.gsub("<", "&lt;")
      else
        content.to_s
      end
    end

    def to_html
      html = String.build do |str|
        str << "<#{@tag_name}"

        if @attributes
          str << @attributes.as(Hash).map { |(attr, value)| " #{attr}=#{value.to_s.inspect}" }.join ""
        end

        if @content
          str << ">"
          str << sanitize_content(@content)
          str << "</#{@tag_name}>"
        else
          str << "/>"
        end
      end

      html
    end

    def to_s
      to_html
    end
  end
end
