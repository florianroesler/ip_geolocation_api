require "ip_geolocation"
IPGeolocation::Log.level = Log::Severity::Debug

class Locater
  ip_source_path = "lib/ip_geolocation/" + IPGeolocation::Lookup::DEFAULT_INPUT_PATH
  ip_source_path = "lib/ip_geolocation/spec/fixtures/excerpt.zip"

  LOOKUP = IPGeolocation::Lookup.new
  LOOKUP.build_index(ip_source_path)

  def self.handle_ip(env, query)
  	address = IPGeolocation::IPAddress.new(query)

  	address_as_int = address.to_u32
  	if address_as_int
  		LOOKUP.find(address_as_int).to_json
  	else
  		env.response.status_code = 422
  		{ error: "Seems like you did not provide a valid IPv4 address or a corresponding integer representation." }.to_json
  	end
  end
end
