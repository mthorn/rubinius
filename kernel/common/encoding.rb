class EncodingError < StandardError
end

class Encoding
  class UndefinedConversionError < EncodingError
  end

  class CompatibilityError < EncodingError
  end

  EncodingMap  = Rubinius::Encoding::EncodingMap
  EncodingList = Rubinius::Encoding::EncodingList

  class Converter
    def initialize(from, to, options={})
    end

    def convert(str)
    end
  end

  def self.aliases
    aliases = {}
    EncodingMap.each do |n, r|
      e = EncodingList[r.last]
      aliases[n.to_s] = e.name unless n.to_s == e.name
    end

    aliases
  end

  def self.compatible?(str1, str2)
    false
  end

  def self.default_external
  end

  def self.default_external=(enc)
  end

  def self.default_internal
  end

  def self.default_internal=(enc)
  end

  def self.find(name)
    key = StringValue(name).upcase

    EncodingMap.each do |n, r|
      return EncodingList[r.last] if n.to_s.upcase == key
    end

    raise ArgumentError, "unknown encoding name - #{name}"
  end

  def self.list
    EncodingList
  end

  def self.locale_charmap
  end

  def self.name_list
    EncodingMap.map do |n, r|
      r.first or EncodingList[r.last].name
    end
  end

  def inspect
    "#<Encoding:#{name}#{" (dummy)" if dummy?}>"
  end

  def names
  end
end

# TODO: This psuedo variable should represent a scripts encoding.
Object.send :define_method, :__ENCODING__ do
  Encoding.new
end
