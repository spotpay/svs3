require 'rubygems'
require 'test/unit'
require 'selenium'

class MyNewSeleniumTest < Test::Unit::TestCase
  def setup
    @verification_errors = []
    if $selenium
      @selenium = $selenium
    else
      @selenium = Selenium::SeleneseInterpreter.new("localhost", 
        4444, "*firefox", "http://localhost:4567", 10000);
      @selenium.start
    end
    @selenium.set_context("test_new")
  end
  
  def teardown
    @selenium.stop unless $selenium
    assert_equal [], @verification_errors
  end
  
  def test_new
    @selenium.open "/test"
    @selenium.wait_for_page_to_load "30000"
  end
end