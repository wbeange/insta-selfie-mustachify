# Homepage (Root path)
get '/' do
  erb :index
end

# Instagram Auth
get "/oauth/connect" do
  redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
end

get "/oauth/callback" do
  response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
  session[:access_token] = response.access_token
  redirect "/selfie"
end

get "/selfie" do
  client = Instagram.client(:access_token => session[:access_token])

  tags = client.tag_search('selfie')

  media = client.tag_recent_media(tags.first.name)

  @media_item = media.first

  erb :selfie
end