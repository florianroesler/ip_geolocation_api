class IpExtractor
  def self.extract(request : HTTP::Request)
    forwarded_for = request.headers["X-Forwarded-For"]?

    if forwarded_for
      forwarded_for.split(',').first.strip
    else
      request.remote_address.as(Socket::IPAddress).address
    end
  end
end
