# require_relative 'gacha'
require_relative './app/meshi_gacha/meshi_gacha'

def get_bot_response_message(word)
  case word
  when /ガチャ/ then
    get_gacha_reply(word)
  when /(ping|生きてる？)/ then
    {
      type: 'text',
      text: '生きとるで〜'
    } 
  end
end