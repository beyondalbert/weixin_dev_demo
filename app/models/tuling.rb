class Tuling
  attr_accessor :api_key
  @@host = "http://www.tuling123.com/openapi/api"

  def initialize(api_key)
    @api_key = api_key
  end

  def send_msg(msg)
    url = "#{@@host}?key=#{@api_key}&info='#{msg}'"
    p url
    response = Typhoeus.get(url)

    if response.code == 200
      result = JSON.parse(response.body)
      p result
      case result['code']
      when 100000
        return ["text", result['text']]
      when 200000
        back = result['text'] + ": \r\n " + result['url']
        return ["text", back] 
      when 302000
        return_array = ["news", result['text']]
        news = []
        result['list'].each do |l|
          news << WeixinRailsMiddleware::ReplyWeixinMessageHelper.generate_article(l['article'], l['source'], l['icon'], l['datailurl'])
        end
        return_array << news
        return_array
      else
      end
    end
  end
end
