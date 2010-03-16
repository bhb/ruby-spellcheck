require File.join(File.dirname(__FILE__), 'test_helper')

class WordCounterTest < Test::Unit::TestCase
  include Construct::Helpers

  should "count number of words" do
    within_construct do |c|
      c.file "test.txt", "socks shoe socks socks flipflops"
      counter = WordCounter.new('test.txt')
      assert_equal 1, counter[:shoe] 
      assert_equal 3, counter[:socks] 
    end
  end

  should "ignore case" do
    within_construct do |c|
      c.file "test.txt", "Joe joe Jane"
      counter = WordCounter.new('test.txt')
      assert_equal 2, counter[:joe] 
    end
  end

  should "report that unseen words appear only once" do
    within_construct do |c|
      c.file "test.txt", "hello goodbye"
      counter = WordCounter.new('test.txt')
      assert_equal 1, counter[:foobar] 
    end
  end

end
