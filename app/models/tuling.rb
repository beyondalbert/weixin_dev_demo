class Tuling
  include WeixinRailsMiddleware::ReplyWeixinMessageHelper

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
        return_array = ["news"]
        news = []
        result['list'].each do |l|
          news << generate_article(l['article'], l['source'], l['icon'], l['detailurl'])
        end
        return_array << news
        return_array
      when 305000
        return_array = ["train_info"]
        news = []
        result['list'].each do |l|
          news << generate_article(l['trainnum'], l['start'] + "(#{l['starttime']})" + "~" + l['terminal'] + "(#l['endtime'])", l['icon'], l['detailurl'])
        end
      when 306000
        return_array = ['flight']
        news = []
        result['list'].each do |l|
          news << generate_article(l['flight'], l['starttime'] + "~" + l['endtime'], l['icon'], '')
        end
      when 308000
        return_array = ['recipe']
        news = []
        result['list'].each do |l|
          news << generate_article(l['name'], l['info'], l['icon'], l['detailurl'])
        end
      else
      end
    end
  end
end
