require 'rubygems'
require 'test/unit'
require 'selenium'
require 'json'
require File.expand_path(File.dirname(__FILE__) + "/./flash_test_helper")
require File.expand_path(File.dirname(__FILE__) + "/./selenese_helper")


class Svs3Test < Test::Unit::TestCase
  include SeleneseHelper
  include FlashTestHelper
  

  
  def test_in_out
    open_widget({:width=>"680", :height=>"400"})
	  svs3_close_parameters = {:element_id => 'svs3_close'}
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

    validate_svs3_in_mask_y85_parameters =
    {
    	:element_id => 'svs3_in_mask',
    	:property => 'y',
    	:value => 85
    }
    invoke_result_string = invoke('validateUIElement', validate_svs3_in_mask_y85_parameters)
    assert_equal(invoke_result_string, 'true')

    svs3_pill_play_parameters = {:element_id => 'svs3_pill_play'}
    invoke('clickUIElement', svs3_pill_play_parameters)
    wait_for_ready

    validate_svs3_in_mask_y0_parameters =
    {
    	:element_id => 'svs3_in_mask',
    	:property => 'y',
    	:value => 0
    }
    invoke_result_string = invoke('validateUIElement', validate_svs3_in_mask_y0_parameters)
    assert_equal(invoke_result_string, 'true')
  end
  
  def test_svs3_buy
    open_widget({:width=>"680", :height=>"400"})
    svs3_buy_parameters = {:element_id => 'svs3_buy'}
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
    open_widget({:width=>"680", :height=>"400"})
    svs3_close_parameters = {:element_id => 'svs3_close'}
    invoke('clickUIElement', svs3_close_parameters)
    wait_for_ready
  
    svs3_pill_buy_parameters = {:element_id => 'svs3_pill_buy'}
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