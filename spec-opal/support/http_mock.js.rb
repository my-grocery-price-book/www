class HTTPMock
  Response = Struct.new(:ok?, :json)

  attr_reader :responses

  def initialize
    @responses = {}
  end

  def ok_response(url, result)
    @responses[url] = Response.new(true, result)
  end

  def failed_response(url)
    @responses[url] = Response.new(false, nil)
  end

  def get(url)
    fail "No response set for #{url}" unless @responses.key?(url)
    yield(@responses[url])
  end
end
