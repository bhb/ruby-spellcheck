class WordCounter
  
  def initialize(path)
    @hash = {}
    words = File.read(path).split(" ")
    words.each do |word|
      @hash[word.downcase.to_sym] ||= 0
      @hash[word.downcase.to_sym] += 1
    end
  end

  def [](key)
    @hash.fetch(key, 1)
  end

end