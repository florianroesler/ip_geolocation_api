require "./spec_helper"

describe "/v1/locate-me" do
  it "responds with the location of the requesting client" do
    headers = HTTP::Headers.new
    headers.add("X-FORWARDED_FOR", "1.0.0.0")
    get "/v1/locate-me", headers: headers

    response.status.to_i.should eq(200)

    JSON.parse(response.body).should eq(
      {
        "alpha_2" => "US",
        "country" => "United States of America",
        "state" => "California",
        "city" => "Los Angeles"
      }
    )
  end
end
