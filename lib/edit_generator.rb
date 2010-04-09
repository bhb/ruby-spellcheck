require 'delegate'

class EditGenerator

  def initialize(word, word_counter)
    @word = word
    @word_counter = word_counter
    @edits = []
    @edits[0] = [EditGeneratingString.new(@word)]
  end

  def candidates
    
  end

  def edits(distance)
    distance.times do |count|
      if @edits[count+1]==nil
        @edits[count+1] = @edits[count].map{|word| word.edits}.flatten.uniq
      end
    end
    puts "number of words #{@edits[distance].length}"
    puts "number of cuttable strings #{CuttableString.cache.length}"
    puts "number of edit strings #{EditGeneratingString.cache.length}"
   debugger
    select_real_words(@edits[distance])
  end

  private

  def select_real_words(words)
    words.select do |word|
      @word_counter.present?(word)
    end
  end

end

class CuttableString < DelegateClass(String)

  def self.cache
    @@cache
  end
  
  def self.get(string)
    @@cache ||= {}
    if @@cache.has_key?(string)
      @@cache[string]
    else
      cstring = self.new(string)
      cstring.freeze
      @@cache[string] = cstring
    end
  end

  def initialize(string)
    super
    @string = string
    @cut_cache = []
    @hash = @string.hash
  end

  def hash
    @hash
  end

  def cut(index)
    #if @cut_cache[index]==nil
      
    #else
      
    #end
    @cut_cache[index] ||= [self.class.get(@string[0,index]), self.class.get(@string[index..-1])]
  end

  def first
    #self.class.get(self.cut(1).first || "")
    self.class.get(@string[0,1] || "")
  end

  def second
    self.class.get(@string[1,1] || "")
  end

  def rest(starting_index=1)
    self.class.get(@string[starting_index..-1] || "")
  end

  def +(other)
    self.class.get(@string+other.to_s)
  end

end

class EditGeneratingString < DelegateClass(String)

  def self.cache
    @@cache
  end

  def self.get(string)
    @@cache ||= {}
    if @@cache.has_key?(string)
      @@cache[string]
    else
      egstring = self.new(string)
      egstring.freeze
      @@cache[string] = egstring
    end
  end

  def initialize(string)
    super
    @string = string
    @alphabet = ('a'..'z')
    @splits = []
    cstring = CuttableString.get(@string)
    cstring.length.times do |i|
      @splits << cstring.cut(i)
    end
    @hash = @string.hash
  end

  def edits
    (deletes + transposes + replaces + inserts).uniq.map{ |x| self.class.get(x)}
  end

  def deletes
    @splits.map do |left, right|
      left + right.rest
    end
  end

  def hash
    @hash
  end

  def transposes
    @splits.map do |left, right|
      left + right.second + right.first + right.rest(2)
    end
  end

  def replaces
    @splits.map do |left, right| 
      @alphabet.map do |letter|
        left + letter + right.rest
      end
    end.flatten
  end

  def inserts
    (@splits + [[@string,""]]).map do |left, right| 
      @alphabet.map do |letter|
        left + letter + right
      end
    end.flatten
  end

end
