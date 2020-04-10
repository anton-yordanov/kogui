require "json"

module Kogui
  # :nodoc:
  class Tag
    @attributes : Hash(String | Symbol, String)?

    def initialize(tag_name : String, attributes, content : (Array(Tag) | Tag | String)?)
      @tag_name = tag_name
      @attributes = sanitize_attributes(attributes)
      @content = content
    end

    def sanitize_attributes(attributes) : Hash(String | Symbol, String)?
      return nil if attributes.nil?

      final_attributes = {} of (Symbol | String) => String

      class_name = attributes[:class_name]? || attributes[:className]?
      final_attributes[:class] = attributes.fetch(:class, class_name).to_s if class_name

      style = attributes[:style]?

      if !style.nil?
        final_attributes["style"] = if style.is_a? NamedTuple
                                      style
                                        .map { |a, v|
                                          "#{a.to_s.tr "_", "-"}:#{v}"
                                        }
                                        .join(";")
                                    else
                                      style.to_s
                                    end
      end

      attributes
        .each { |key, value|
          key = key.to_s

          if key[0, 2] != "on" &&
             key != "style" &&
             key != "class_name" &&
             key != "className"
            final_attributes[key] = value.to_s
          end
        }

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
