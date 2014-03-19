class EmoticonsController < ApplicationController
  def index
    @emoticons = emoticons
  end

  def export
    send_data(AdiumFormatter.format(emoticons), :type => 'application/zip', :filename => 'HipChat.AdiumEmoticonSet.zip')
  end

  private

  def emoticons
    Emoticon.fetch_all(access_token)
  end

  def access_token
    params.require(:access_token)
  end
end
