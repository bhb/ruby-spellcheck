
class WordCounter

  def self.for_path(path)
    text = File.read(path)
    words = text.scan(/[a-zA-Z]+/)
    self.new(words)
  end
  
  def initialize(words)
    @hash = {}
    words.each do |word|
      downcased = word.downcase
      @hash[downcased] ||= 0
      @hash[downcased] += 1
    end
  end

  def count(key)
    @hash.fetch(key, 1)
  end

  def present?(key)
    @hash.has_key?(key)
  end

end
