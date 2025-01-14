class MockHTTPClient
  def get(url, _header = {})
    build_mock_response(:get, url, nil)
  end

  def post(url, payload, _header = {})
    build_mock_response(:post, url, payload)
  end

  def put(url, payload, _header = {})
    build_mock_response(:put, url, payload)
  end

  def delete(url, _header = {})
    build_mock_response(:delete, url, nil)
  end

  private

  def build_mock_response(method, url, payload)
    {
      method: method,
      url: url,
      payload: payload
    }
  end
end
