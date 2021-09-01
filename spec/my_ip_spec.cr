require "./spec_helper"

describe "/v1/my-ip" do
  it "responds with the ip of the requesting client" do
    headers = HTTP::Headers.new
    headers.add("X-FORWARDED_FOR", "172.168.1.0")
    get "/v1/my-ip", headers: headers

    response.status.to_i.should eq(200)
    response.body.should eq("172.168.1.0")
  end
end
