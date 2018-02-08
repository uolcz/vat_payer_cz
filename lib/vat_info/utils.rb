module VatInfo
  module Utils
    def self.wrap_in_array(content)
      content.is_a?(Array) ? content : [content]
    end
  end
end
