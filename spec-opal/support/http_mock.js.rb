class HTTPMock
  class Response < Struct.new(:ok?, :json)
  end

  attr_reader :responses

  def initialize
    @responses = {}
  end

  def set_ok_response(url, result)
    @responses[url] = Response.new(true,result)
  end

  def set_failed_response(url)
    @responses[url] = Response.new(false,nil)
  end

  def get(url)
    fail "No response set for #{url}" unless @responses.key?(url)
    yield(@responses[url])
  end
end
