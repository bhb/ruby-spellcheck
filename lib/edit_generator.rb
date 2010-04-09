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
        @edits[count+1] = (@edits[count].map{|word| word.edits}).flatten.uniq
      end
    end
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

  def initialize(string)
    super
    @string = string
  end

  def cut(index)
    [CuttableString.new(@string[0,index]), CuttableString.new(@string[index..-1])]
  end

  def first
    CuttableString.new(@string[0,1] || "")
  end

  def second
    CuttableString.new(@string[1,1] || "")
  end

  def rest(starting_index=1)
    CuttableString.new(@string[starting_index..-1] || "")
  end

  def +(other)
    CuttableString.new(@string+other.to_s)
  end

end


class EditGeneratingString < DelegateClass(String)

  def initialize(string)
    super
    @string = string
    @alphabet = ('a'..'z')
    @splits = []
    cstring = CuttableString.new(@string)
    cstring.length.times do |i|
      @splits << cstring.cut(i)
    end
  end

  def edits
    (deletes + transposes + replaces + inserts).map{ |x| EditGeneratingString.new(x)}
  end

  def deletes
    @splits.map do |left, right|
      left + right.rest
    end
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
    (@splits<<[@string,""]).map do |left, right| 
      @alphabet.map do |letter|
        left + letter + right
      end
    end.flatten
  end

end
