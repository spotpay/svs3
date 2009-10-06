require 'rubygems'
require 'sinatra'
get '/test' do
  myvar = <<doc
   <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" 
      codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0"     
      id="Musicane" type="application/x-shockwave-flash" height="#{params[:height]}" width="#{params[:width]}">
      <param name="movie" value="/TestHarness.swf?width=#{params[:width]}&height=#{params[:height]}&load_url=/SVS3.swf">
      <param name="quality" value="high">
      <embed src="/TestHarness.swf?width=#{params[:width]}&height=#{params[:height]}&load_url=/SVS3.swf"
            quality="high" name="Musicane" type="application/x-shockwave-flash" 
            pluginspage="http://www.macromedia.com/go/getflashplayer" height="#{params[:height]}" width="#{params[:width]}">
      </embed>
    </object>
doc
end