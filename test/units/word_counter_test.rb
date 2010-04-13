require File.join(File.dirname(__FILE__), '..', 'test_helper')

class WordCounterTest < Test::Unit::TestCase
  include Construct::Helpers

  should "report whether word is included" do
    within_construct do |c|
      c.file "test.txt", "socks shoe socks socks flipflops"
      counter = WordCounter.for_path('test.txt')
      assert_equal true, counter.present?(:socks)
      assert_equal false, counter.present?(:sandals)
    end
  end

  should "determine if any word is include" do
    within_construct do |c|
      c.file "test.txt", "socks shoe socks socks flipflops"
      counter = WordCounter.for_path('test.txt')
      assert_equal true, counter.any_present?([:socks, :sandals])
      assert_equal false, counter.any_present?([:sandals, :boots])
    end
  end
  
  should "count number of words" do
    within_construct do |c|
      c.file "test.txt", "socks shoe socks socks flipflops"
      counter = WordCounter.for_path('test.txt')
      assert_equal 1, counter.count(:shoe)
      assert_equal 3, counter.count(:socks)
    end
  end

  should "ignore case" do
    within_construct do |c|
      c.file "test.txt", "Joe joe Jane"
      counter = WordCounter.for_path('test.txt')
      assert_equal 2, counter.count(:joe)
    end
  end

  should "report that unseen words appear only once" do
    within_construct do |c|
      c.file "test.txt", "hello goodbye"
      counter = WordCounter.for_path('test.txt')
      assert_equal 1, counter.count(:foobar)
    end
  end

end
