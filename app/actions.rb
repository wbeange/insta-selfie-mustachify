# Homepage (Root path)
get '/' do
  instagram_client = Instagram.client(:access_token => session[:access_token])
  rekognize_client = Rekognize::Client::Base.new(api_key: settings.rekognize_client_id, api_secret: settings.rekognize_client_secret)

  tags = instagram_client.tag_search('selfie')
  media = instagram_client.tag_recent_media(tags.first.name)
  @media_item = media.first

  urls = "#{@media_item.images.standard_resolution.url}/base64"

  @result = rekognize_client.face_detect(urls: urls, jobs: 'face_detect_part')

  @canvasWidth = @result['ori_img_size']['width']
  @canvasHeight = @result['ori_img_size']['height']

  erb :index
end
