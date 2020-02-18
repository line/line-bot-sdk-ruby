require "./src/Weather"
require "./src/WeatherInfo"

weatherobj = Weather.new
info = weatherobj.doProcess()

puts "今日、#{info.today()} 東京の天気です。"
puts "天気    ：#{info.todayTelop()}"
puts "最高気温：#{info.todayTempMax()}"
puts "最低気温：#{info.todayTempMin()}"
puts ""

puts "明日、#{info.tmrw()} 東京の天気です。"
puts "天気    ：#{info.tmrwTelop()}"
puts "最高気温：#{info.tmrwTempMax()}"
puts "最低気温：#{info.tmrwTempMin()}"
puts ""


puts "【概要】"
puts info.description()