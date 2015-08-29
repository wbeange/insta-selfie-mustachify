# Homepage (Root path)
get '/' do
  erb :index
end

# Instagram Auth
get "/oauth/connect" do
  redirect Instagram.authorize_url(:redirect_uri => settings.instagram_callback_url)
end

get "/oauth/callback" do
  response = Instagram.get_access_token(params[:code], :redirect_uri => settings.instagram_callback_url)
  session[:access_token] = response.access_token
  redirect "/selfie"
end

get "/selfie" do
  instagram_client = Instagram.client(:access_token => session[:access_token])
  rekognize_client = Rekognize::Client::Base.new(api_key: settings.rekognize_client_id, api_secret: settings.rekognize_client_secret)

  tags = instagram_client.tag_search('selfie')
  media = instagram_client.tag_recent_media(tags.first.name)
  @media_item = media.first

  @result = rekognize_client.face_detect(urls: "#{@media_item.images.standard_resolution.url}/base64", jobs: 'face_detect_part')

  erb :selfie
end
