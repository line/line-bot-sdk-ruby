class WeatherInfo
  attr_accessor :description,
  :todayTelop,
  :today,
  :todayTempMin,
  :todayTempMax,
  :tmrwTelop,
  :tmrw,
  :tmrwTempMin,
  :tmrwTempMax
  :comment

  # コンストラクタ
  def initialize()
  end

  # 概要
  def description()
    @description
  end

  # 概要
  def description=(value)
    @description = value
  end

  # 本日テロップ
  def todayTelop()
    @todayTelop
  end

  # 本日テロップ
  def todayTelop=(value)
    @todayTelop = value
  end

  # 本日最低気温
  def todayTempMin()
    @todayTempMin
  end

  # 本日最低気温
  def todayTempMin=(value)
    @todayTempMin = value
  end

  # 本日最高気温
  def todayTempMax()
    @todayTempMax
  end

  # 本日最高気温
  def todayTempMax=(value)
    @todayTempMax = value
  end

  # 明日テロップ
  def tmrwTelop()
    @tmrwTelop
  end

  # 明日テロップ
  def tmrwTelop=(value)
    @tmrwTelop = value
  end

  # 明日最低気温
  def tmrwTempMin()
    @tmrwTempMin
  end

  # 明日最低気温
  def tmrwTempMin=(value)
    @tmrwTempMin = value
  end

  # 明日最高気温
  def tmrwTempMax()
    @tmrwTempMax
  end

  # 明日最高気温
  def tmrwTempMax=(value)
    @tmrwTempMax = value
  end

  # コメント
  def comment()
    @comment
  end

  # 明日最高気温
  def comment=(value)
    @comment = value
  end

end