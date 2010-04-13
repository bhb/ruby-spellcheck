require File.join(File.dirname(__FILE__), '..', 'test_helper')

class SpellcheckerTest < Test::Unit::TestCase

  should "return 'something' when given 'somethin'" do
    checker = Spellchecker.new
    assert_equal 'something', checker.correct('somethin')
  end

end
