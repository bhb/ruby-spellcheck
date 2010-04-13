
class WordCounter

  def self.for_path(path)
    text = File.read(path)
    words = text.scan(/[a-zA-Z]+/)
    self.new(words)
  end
  
  def initialize(words)
    @hash = {}
    words.each do |word|
      @hash[word.downcase.to_sym] ||= 0
      @hash[word.downcase.to_sym] += 1
    end
  end

  def count(key)
    @hash.fetch(key.to_sym, 1)
  end

  def present?(key)
    @hash.has_key?(key.to_sym)
  end

  def any_present?(keys)
    keys.any? {|key| present? key}
  end

end
