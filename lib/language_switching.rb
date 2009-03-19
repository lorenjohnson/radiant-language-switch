module LanguageSwitching
  def cache?
    false
  end

  def process(request, response)
    @language = request.cookies["language"].value.to_s unless request.cookies["language"].blank?
    unless request.parameters["language"].blank?
      if request.parameters["language"] == "browser"
        cookie = CGI::Cookie.new("name" => "language", "value" => "", "expires" => Time.at(0), "domain" => request.domain)
        response.headers["cookie"] << cookie
        @language = nil
      else
        # options = { :name => "language", :value => request.parameters["language"], "path" => "/" }
        cookie = CGI::Cookie.new("name" => "language", "value" => request.parameters["language"], "path" => "/", "domain" => request.domain)
        response.headers["cookie"] << cookie
        @language = request.parameters["language"]
      end
    end

    # content of core Page.process
    @request, @response = request, response
    if layout
      content_type = layout.content_type.to_s.strip
      @response.headers['Content-Type'] = content_type unless content_type.empty?
    end
    headers.each { |k,v| @response.headers[k] = v }
    @response.body = render
    @request, @response = nil, nil
  end
end