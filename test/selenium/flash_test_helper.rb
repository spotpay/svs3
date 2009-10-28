module FlashTestHelper

  def get_invocation_script(method_name, parameter)
	  if parameter != '' 
  		serilaized_param = parameter.to_json
  		script = "this.browserbot.getCurrentWindow().getFlash().#{method_name}("
  		script << "#{serilaized_param})" if serilaized_param[0] == "\""
  		script << "'#{serilaized_param}')" if serilaized_param[0] != "\""
  	else 
  		get_script("getFlash().#{method_name}()")
  	end
  end
  
  def invoke(method_name, parameter)
	  if parameter != '' 
  		@selenium.get_eval(get_invocation_script(method_name, parameter))
  	else
  		@selenium.get_eval(get_invocation_script(method_name, ""))
  	end	
  end

  def open_widget(widget_params)
    navigate("test?#{widget_params.to_url_params}")
    open_widget_helper
  end
  
  def open_widget_helper
    sleep 3
  end
  
  def wait_for_embed
    wait_for_autoreset_condition("this.browserbot.getCurrentWindow().embed")
  end
  
  def wait_for_ready
    wait_for_autoreset_condition("this.browserbot.getCurrentWindow().ready")
  end
end

class Hash
  def to_url_params
    elements = []
    keys.size.times do |i|
      elements << "#{keys[i]}=#{CGI::escape(values[i])}"
    end
    elements.join('&')
  end

  def self.from_url_params(url_params)
    result = {}.with_indifferent_access
    url_params.split('&').each do |element|
      element = element.split('=')
      result[element[0]] = element[1]
    end
    result
  end
end

