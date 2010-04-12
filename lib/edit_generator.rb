require 'delegate'

class EditGenerator

  def initialize(word, word_counter)
    @word = word
    @word_counter = word_counter
    @edits = []
    @edits[0] = [@word] #[EditGeneratingString.get(@word)]
  end

  def candidates
    
  end

  def edits(distance)
    distance.times do |count|
      if @edits[count+1]==nil
        @edits[count+1] = @edits[count].map{|word| word.edits}.flatten.uniq
      end
    end
    #puts "number of words #{@edits[distance].length}"
    #puts "number of cuttable strings #{CuttableString.cache.length}"
    #puts "number of edit strings #{EditGeneratingString.cache.length}"
    @edits[distance]
    #select_real_words(@edits[distance])
  end

  private

  def select_real_words(words)
    words.select do |word|
      @word_counter.present?(word)
    end
  end

end

# TODO - move to 'lib/ext' or something

# Yes, monkey-patching sucks, but creating decorators was prohibitively slow
class String

  ALPHABET = ('a'..'z').to_a

  def cut(index)
    @cut_cache ||= []
    @cut_cache[index] ||= [self[0,index], self[index,length-index]]
  end

  def first
    self[0,1] || ""
  end

  def second
    self[1,1] || ""
  end

  def rest(starting_index=1)
    self[starting_index,self.length-starting_index] || ""
  end

  def edits
    @splits = generate_splits
    (deletes + transposes + replaces + inserts).uniq   # .map{ |x| self.class.get(x)}
  end

  private

  def generate_splits
    return @splits if @splits
    @splits = []
    length.times do |i|
      @splits << cut(i)
    end
    @splits
  end

  def deletes
    @splits.map do |left, right|
      "#{left}#{right.rest}"
    end
  end

  def transposes
    @splits.map do |left, right|
      "#{left}#{right.second}#{right.first}#{right.rest(2)}"
    end
  end

  def replaces
    arr = []
    @splits.each do |left, right|
      ALPHABET.each do |letter|
        arr << "#{left}#{letter}#{right.rest}"
      end
    end
    arr
  end

  def inserts
    arr = []
    (@splits + [[self,""]]).map do |left, right| 
      ALPHABET.map do |letter|
        arr << "#{left}#{letter}#{right}"
      end
    end
    arr
  end

end


# class CuttableString < DelegateClass(String)

#   def self.cache
#     @@cache
#   end
  
#   def self.get(string)
#     @@cache ||= {}
#     if @@cache.has_key?(string)
#       @@cache[string]
#     else
#       cstring = self.new(string)
#       cstring.freeze
#       @@cache[string] = cstring
#     end
#   end

#   def initialize(string)
#     super
#     @string = string
#     @cut_cache = []
#     @hash = @string.hash
#   end

#   def hash
#     @hash
#   end

#   def cut(index)
#     #if @cut_cache[index]==nil
      
#     #else
      
#     #end
#     @cut_cache[index] ||= [self.class.get(@string[0,index]), self.class.get(@string[index..-1])]
#   end

#   def first
#     #self.class.get(self.cut(1).first || "")
#     self.class.get(@string[0,1] || "")
#   end

#   def second
#     self.class.get(@string[1,1] || "")
#   end

#   def rest(starting_index=1)
#     self.class.get(@string[starting_index..-1] || "")
#   end

#   def +(other)
#     self.class.get(@string+other.to_s)
#   end

# end

class EditGeneratingString < DelegateClass(String)

  ALPHABET = ('a'..'z').to_a

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
    # PERF - make this a constant
    @splits = []
    #cstring = CuttableString.get(@string)
    #cstring.length.times do |i|
    @string.length.times do |i|
      @splits << @string.cut(i)
    end
    #end
    @hash = @string.hash
  end

  def hash
    @hash
  end

  def edits
    (deletes + transposes + replaces + inserts).uniq.map{ |x| self.class.get(x)}
  end

  def deletes
    @splits.map do |left, right|
      "#{left}#{right.rest}"
    end
  end

  def transposes
    @splits.map do |left, right|
      "#{left}#{right.second}#{right.first}#{right.rest(2)}"
    end
  end

  def replaces
    arr = []
    @splits.each do |left, right|
      ALPHABET.each do |letter|
        arr << "#{left}#{letter}#{right.rest}"
      end
    end
    arr
  end

  def inserts
    arr = []
    (@splits + [[@string,""]]).map do |left, right| 
      ALPHABET.map do |letter|
        arr << "#{left}#{letter}#{right}"
      end
    end
    arr
  end

end
