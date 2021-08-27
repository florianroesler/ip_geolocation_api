require "./ip_extractor"
require "./locater"

before_all do |env|
	env.response.content_type = "application/json"
end

get "/" do
	"https://github.com/florianroesler/ip_geolocation_api"
end

get "/status" do
	{ status: "Running!" }.to_json
end

get "/v1/locate" do |env|
	query = env.params.query.fetch("q", "").strip

	Locater.handle_ip(env, query)
end

get "/v1/my-ip" do |env|
	IpExtractor.extract(env.request)
end

get "/v1/locate-me" do |env|
	query = IpExtractor.extract(env.request)

	Locater.handle_ip(env, query)
end
