require File.join(File.dirname(__FILE__), 'test_helper')

class EditGeneratingStringTest < Test::Unit::TestCase

  should "give all deletes" do
    deletes = EditGeneratingString.new("abc").deletes
    assert deletes.include?("ab")
    assert deletes.include?("bc")
    assert deletes.include?("ac")
    assert_equal 3, deletes.length
    deletes.each do |edit|
      assert_equal 2, edit.length
    end
  end

  should "give all transposes" do
    transposes = EditGeneratingString.new("abc").transposes
    assert transposes.include?("bac")
    assert transposes.include?("acb")
    assert transposes.include?("abc")
    assert_equal 3, transposes.length
    transposes.each do |edit|
      assert_equal 3, edit.length
    end
  end

  should "give all replaces" do
    replaces = EditGeneratingString.new("ab").replaces
    # only test a subset
    assert replaces.include?("zb")
    assert replaces.include?("az")
    assert_equal 26+26, replaces.length
    replaces.each do |edit|
      assert_equal 2, edit.length
    end
    
  end

  should "give all inserts" do
    inserts = EditGeneratingString.new("ab").inserts
    # only test a subset
    assert inserts.include?("zab")
    assert inserts.include?("azb")
    assert inserts.include?("abz")
    assert_equal 26+26+26, inserts.length
    inserts.each do |edit|
      assert_equal 3, edit.length
    end

  end

end
