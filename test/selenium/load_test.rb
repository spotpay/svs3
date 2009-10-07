require 'rubygems'
require 'test/unit'
require 'selenium'
require 'json'
require File.expand_path(File.dirname(__FILE__) + "/./flash_test_helper")
require File.expand_path(File.dirname(__FILE__) + "/./selenese_helper")


class LoadTest < Test::Unit::TestCase
  
  include SeleneseHelper
  include FlashTestHelper
  
  @@TestTimeout = 30*1000
  @selenium
  
  def setup
    @verification_errors = []
    if $selenium
      @selenium = $selenium
    else
      @selenium = Selenium::SeleneseInterpreter.new("localhost", 
        4444, "*firefox", "http://localhost:4567", 10000);
      @selenium.start
    end
  end
  
  def teardown
    @selenium.stop unless $selenium
    assert_equal [], @verification_errors
  end
  
  def test_new
    navigate("test")
    #sleep 20000
  end
end


