module SeleneseHelper 
  @@TestTimeout = 30*1000
  @selenium
  
  def setup
    @verification_errors = []
    if $selenium
      @selenium = $selenium
    else
      @selenium = Selenium::SeleneseInterpreter.new("localhost", 
        4444, "*firefox #{ENV['FIREFOX_PATH']}", "http://localhost:4567", 10000);
      @selenium.start
    end
  end
  
  def teardown
    @selenium.stop unless $selenium
    assert_equal [], @verification_errors
  end
  
  def get_cookie(cookie_name)
    result = @selenium.get_eval("this.browserbot.getCurrentWindow().GetCookie('#{cookie_name}')")
    result = null if result == "null"
  end
  
  def get_eval(script)
    s = get_script(script)
    @selenium.get_eval(s)
  end
  
  def get_find_element_script(locator)
    "selenium.isElementPresent('#{locator}')"
  end
  
  def get_script(script_name)
    "this.browserbot.getCurrentWindow().#{script_name}"
  end
  
  def navigate(path)
    path = "http://localhost:4567/#{path}" if !starts_with_http?(path)
    @selenium.open(path)
  end
  
  def starts_with_http?(path)
    if path.size < 7
      return false
    end
    if path[0..6] == "http://"
      return true
    end
    return false
  end
  
  def wait_for_autoreset_condition(var)
    script = "selenium.getEval('#{var}');"
    @selenium.wait_for_condition(script, @@TestTimeout)
    @selenium.get_eval("this.browserbot.getCurrentWindow().resetReady();")
  end
        
  def wait_for_condition(script)
    @selenium.wait_for_condition("selenium.getEval('#{script}');", @@TestTimeout)
  end

  def wait_for_element(locator)
    script = get_find_element_script(locator)
    @selenium.wait_for_condition(script)
  end

  def wait_for_page_to_load
    @selenium.wait_for_page_to_load(@@TestTimeout)
  end
end