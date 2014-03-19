class Emoticon
  class << self
    def fetch_all(auth_token)
      fetch_all_from('https://api.hipchat.com/v2/emoticon', auth_token)
    end

    private

    def fetch_all_from(url, auth_token, results = [])
      response = Faraday.get(url, {auth_token: auth_token})
      raise response.body unless response.status == 200
      json = JSON.parse(response.body)

      json['items'].each do |item|
        results << Emoticon.new(item['shortcut'], item['url'])
      end

      if json['items'].size && json['links']['next']
        fetch_all_from(json['links']['next'], auth_token, results)
      end

      results
    end
  end

  attr_accessor :shortcut, :url

  def initialize(shortcut, url)
    @shortcut = shortcut
    @url = url
  end
end
