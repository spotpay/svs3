require 'rubygems'
require 'sinatra'
get '/test' do
  myvar = <<doc
   <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" 
      codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0"     
      id="TestHarness" 
	  type="application/x-shockwave-flash" 
	  height="#{params[:height]}" 
	  width="#{params[:width]}">
      
	  <param name="movie" 	value="/TestHarness.swf?width=#{params[:width]}&height=#{params[:height]}&load_url=#{params[:load_url]}&bkg_img=#{params[:bkg_img]}&child_y=#{params[:child_y]}&child_x=#{params[:child_x]}">
      <param name="quality" value="high">
	  
      <embed	src="/TestHarness.swf?width=#{params[:width]}&height=#{params[:height]}&load_url=#{params[:load_url]}&bkg_img=#{params[:bkg_img]}&child_y=#{params[:child_y]}&child_x=#{params[:child_x]}"
            quality="high" 
			name="Musicane" 
			type="application/x-shockwave-flash" 
            pluginspage="http://www.macromedia.com/go/getflashplayer" 
			height="#{params[:height]}" 
			width="#{params[:width]}">
      </embed>
    </object>
doc
end