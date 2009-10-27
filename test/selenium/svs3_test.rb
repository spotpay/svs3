require 'rubygems'
require 'test/unit'
require 'selenium'
require 'json'
require File.expand_path(File.dirname(__FILE__) + "/./flash_test_helper")
require File.expand_path(File.dirname(__FILE__) + "/./selenese_helper")


class Svs3Test < Test::Unit::TestCase
  
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
  
  def test_in_out
    navigate("test")
	svs3_close_parameters = {:element_id => 'svs3_close', :wait_for_ready => true}
	invoke('clickUIElement', svs3_close_parameters)
	wait_for_ready
	
	validate_svs3_pill_x_parameters =
  	{
  		:element_id => 'svs3_pill',
  		:property => 'x',
  		:value => 0
  	}
	invoke_result_string = invoke('validateUIElement', validate_svs3_pill_x_parameters)
  	assert_equal(invoke_result_string, 'true')
	
	validate_svs3_in_state_mask_y85_parameters =
  	{
  		:element_id => 'svs3_in_state',
  		:property => 'mask.y',
  		:value => 85
  	}
	invoke_result_string = invoke('validateUIElement', validate_svs3_in_state_mask_y85_parameters)
  	assert_equal(invoke_result_string, 'true')
	
	svs3_pill_play_parameters = {:element_id => 'svs3_pill_play', :wait_for_ready => true}
	invoke('clickUIElement', svs3_pill_play_parameters)
	wait_for_ready
	
	validate_svs3_in_state_mask_y0_parameters =
  	{
  		:element_id => 'svs3_in_state',
  		:property => 'mask.y',
  		:value => 0
  	}
	invoke_result_string = invoke('validateUIElement', validate_svs3_in_state_mask_y0_parameters)
  	assert_equal(invoke_result_string, 'true')	
    #sleep 20000
  end
  
  def test_svs3_buy
	navigate("test")
	svs3_buy_parameters = {:element_id => 'svs3_buy', :wait_for_ready => true}
	invoke('clickUIElement', svs3_buy_parameters)
	wait_for_ready
	
	validate_splashPage_visible_parameters =
  	{
  		:element_id => 'splashPage',
  		:property => 'visible',
  		:value => true
  	}
	invoke_result_string = invoke('validateUIElement', validate_splashPage_visible_parameters)
  	assert_equal(invoke_result_string, 'true')	
  end
  
  def test_pill_buy
	navigate("test")
	svs3_close_parameters = {:element_id => 'svs3_close', :wait_for_ready => true}
	invoke('clickUIElement', svs3_close_parameters)
	wait_for_ready
	
	svs3_pill_buy_parameters = {:element_id => 'svs3_pill_buy', :wait_for_ready => true}
	invoke('clickUIElement', svs3_pill_buy_parameters)
	wait_for_ready
	
	validate_splashPage_visible_parameters =
  	{
  		:element_id => 'splashPage',
  		:property => 'visible',
  		:value => true
  	}
	invoke_result_string = invoke('validateUIElement', validate_splashPage_visible_parameters)
  	assert_equal(invoke_result_string, 'true')	
  end  
end