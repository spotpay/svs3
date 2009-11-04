require 'rubygems'
require 'sinatra'
require 'json'

valid_campaign = <<doc
	{
	  "start_date": "/Date(39482394834)/",
	  "end_date": "/Date(323292922)/",
	  "publisher_id": 234342,
	  "asset_id": 23423432,
	  "products": 
	  [
		{
		  "sku": "23420903294",
		  "sku_hash": "239298928",
		  "price": 99,
		  "currency": "USD",
		  "price_hash": "23423423dAV",
		  "title": "Birthday Sex",
		  "description": "What a song!", 
		  "album_title": "Birthday Sex - The Album",
		  "artist": "jeremih",
		  "img_url": "http://localhost:4567/albumArt.jpg" 
		}
	  ]
	}
doc

get '/test' do
  myvar = <<doc
  <html>
  <head>
  <script language="javascript" type="text/javascript" src="/flashtest.js"></script>
  </head>
  <body>
   <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" 
      codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0"     
      id="FlashObjectIE" type="application/x-shockwave-flash" height="#{params[:height]}" width="#{params[:width]}">
      <param name="movie" value="/TestHarness.swf?width=#{params[:width]}&height=#{params[:height]}&load_url=/SVS3.swf&bkg_img=/youtube.png&child_y=275&child_x=0">
      <param name="quality" value="high">
      <embed id="FlashObjectFF" src="/TestHarness.swf?width=#{params[:width]}&height=#{params[:height]}&load_url=/SVS3.swf&bkg_img=/youtube.png&child_y=275&child_x=0"
            quality="high" name="Musicane" type="application/x-shockwave-flash" 
            pluginspage="http://www.macromedia.com/go/getflashplayer" height="#{params[:height]}" width="#{params[:width]}">
      </embed>
    </object>
  </body>
doc
end

# curl http://localhost:4567/campaigns/123_456
#get "/campaigns/:publisher_id-asset_id" do
get "/campaigns/:publisherid_assetid" do	#<publisher_id>_<asset_id> tokenized component
	content_type :json
	valid_campaign 				#return valid_campaign under all conditions.
end