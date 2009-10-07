module FlashTestHelper
  
  def get_invocation_script(method_name)
    get_script("getFlash().#{method_name}()")
  end

  def get_invocation_script(method_name, parameter)
    serilaized_param = parameter.to_json
    script = "this.browserbot.getCurrentWindow().getFlash().#{method_name}("
    script << "#{serilaized_param})" if serilaized_param[0] == "\""
    script << "'#{serilaized_param}')" if serilaized_param[0] != "\""
  end
  
  def invoke(method_name)
    @selenium.get_eval(get_invocation_script(methodname))
  end
  
  def invoke(method_name, parameter)
    @selenium.get_eval(get_invocation_script(methodname, parameter))
  end
  
  def open_widget(wid_name, pid)
    navigate("/testing/flash/" + widName + "/" + pid + "/empty");
    open_widget_helper()
  end
  
  def open_widget(wid_name, pid, aid)
    navigate("/testing/flash/" + widName + "/" + pid + "/" + aid);   
    open_widget_helper()
  end
  
  def open_widget_helper
    sleep 3
    wait_for_condition get_invocation_script("isReady");            
    invoke("cancelAutoDiscover");
  end
  
  def wait_for_embed
    wait_for_autoreset_condition("this.browserbot.getCurrentWindow().embed")
  end
  
  def wait_for_ready
    wait_for_autoreset_condition("this.browserbot.getCurrentWindow().ready")
  end
end