require 'httpclient'
require 'resolv'
require 'json'
require 'yaml'
require './src/WeatherInfo'

class Weather

  @@DESCRIPTION = "description"
  @@TEXT = "text"
  @@FORECASTS = "forecasts"
  @@TELOP = "telop"
  @@DATE = "date"
  @@TEMPERATURE = "temperature"
  @@CELSIUS = "celsius"
  @@MIN = "min"
  @@MAX = "max"
  @@TODAY = 0
  @@TMRW = 1

  # コンストラクタ
  def initialize()
  end

  # メイン処理メソッド
  def doProcess()
    # 拠点コード
    keyWord = YAML.load_file('./config/config.yml')["location-code"]
    # keyWord = "130010"
    # 天気API URL取得
    url = YAML.load_file('./config/config.yml')["weather-url"]
    # url = "http://weather.livedoor.com/forecast/webservice/json/v1"
    return analysisWeather(connectionAPI(keyWord, url))
  end

  # API接続部
  # 戻り値:ハッシュ化されたレスポンス
  def connectionAPI(keyWord, url)
    # http接続クライアントの生成
    client = HTTPClient.new
    # 指定した拠点のコードをリクエストに設定する。
    query = { 'city' => keyWord }
    # APIリクエスト
    res = client.get(url, query)
    # ハッシュ化して返却
    return JSON.parse(res.body)
  end

  # 天気情報をHashより解析する
  def analysisWeather(hash)

    info = WeatherInfo.new
    # 概要の取得
    info.description=(convertNil(hash.dig(@@DESCRIPTION, @@TEXT)))

    # 本日の天気情報
    info.todayTelop=(convertNil(hash.dig(@@FORECASTS, @@TODAY, @@TELOP)))
    info.today=(convertNil(hash.dig(@@FORECASTS, @@TODAY, @@DATE)))
    info.todayTempMin=(convertNil(hash.dig(@@FORECASTS, @@TODAY, @@TEMPERATURE, @@MIN, @@CELSIUS)))
    info.todayTempMax=(convertNil(hash.dig(@@FORECASTS, @@TODAY, @@TEMPERATURE, @@MAX, @@CELSIUS)))

    # 明日の天気情報
    info.tmrwTelop=(convertNil(hash.dig(@@FORECASTS, @@TMRW, @@TELOP)))
    info.tmrw=(convertNil(hash.dig(@@FORECASTS, @@TMRW, @@DATE)))
    info.tmrwTempMin=(convertNil(hash.dig(@@FORECASTS, @@TMRW, @@TEMPERATURE, @@MIN, @@CELSIUS)))
    info.tmrwTempMax=(convertNil(hash.dig(@@FORECASTS, @@TMRW, @@TEMPERATURE, @@MAX, @@CELSIUS)))

    return info
  end

  # nil判定、nilの場合は「-」を返却
  def convertNil(value)
    return value == nil ? "－" : value
  end
end