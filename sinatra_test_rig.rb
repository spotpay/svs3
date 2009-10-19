require 'rubygems'
require 'sinatra'

valid_campaign = <<doc
	{
	  "products": 
	  [
		{
		  "sku": "23420903294",
		  "sku_hash": "239298928",
		  "price": 0.99,
		  "price_hash": "23423423dAV",
		  "title": "Birthday Sex",
		  "description": "What a song!" 
		  "album_title": "Birthday Sex - The Album",
		  "artist": "jeremih",
		  "img_url": "http://static2.ak.musicane.com/thumbnailer/7738ba56-2fba-46c6-a3b2-e889810e30f3/131/131/0" 
		}
	  ]
	}
doc

get '/test' do
  myvar = <<doc
   <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" 
      codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0"     
      id="Musicane" type="application/x-shockwave-flash" height="#{params[:height]}" width="#{params[:width]}">
      
	  <param name="movie" value="/TestHarness.swf?width=#{params[:width]}&height=#{params[:height]}&load_url=/SVS3.swf&bkg_img=/youtube.png&child_y=275">
      <param name="quality" value="high">
      <embed src="/TestHarness.swf?width=#{params[:width]}&height=#{params[:height]}&load_url=/SVS3.swf&bkg_img=/youtube.png&child_y=275"
            quality="high" name="Musicane" type="application/x-shockwave-flash" 
            pluginspage="http://www.macromedia.com/go/getflashplayer" height="#{params[:height]}" width="#{params[:width]}">
      </embed>
    </object>
doc
end

# curl http://localhost:4567/campaigns/123_456
#get "/campaigns/:publisher_id-asset_id" do
get "/campaigns/:publisherid_assetid" do	#<publisher_id>_<asset_id> tokenized component
	#return valid_campaign under all conditions.
	valid_campaign 
end