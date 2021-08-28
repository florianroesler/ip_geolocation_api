require "./spec_helper"

describe "/v1/locate" do
  context "when querying for an ip" do
    it "responds with the json of the location" do
      get "/v1/locate?q=1.0.0.0"
      JSON.parse(response.body).should eq(
        {
          "alpha_2" => "US",
          "country" => "United States of America",
          "state" => "California",
          "city" => "Los Angeles"
        }
      )
    end

    context "with an invalid ip" do
      it "returns a 422" do
        get "/v1/locate?q=-256.256.256.256"
        response.status.should eq HTTP::Status::UNPROCESSABLE_ENTITY
      end

      it "responds with a json error" do
        get "/v1/locate?q=-1"
        JSON.parse(response.body)["error"].to_s.should contain "did not provide a valid IPv4 address "
      end
    end
  end

  context "when querying the integer representation of an ip" do
    it "responds with the json of the location" do
      get "/v1/locate?q=16777216"
      JSON.parse(response.body).should eq(
        {
          "alpha_2" => "US",
          "country" => "United States of America",
          "state" => "California",
          "city" => "Los Angeles"
        }
      )
    end

    context "with an invalid integer" do
      it "returns a 422" do
        get "/v1/locate?q=-1"
        response.status.should eq HTTP::Status::UNPROCESSABLE_ENTITY
      end

      it "responds with a json error" do
        get "/v1/locate?q=-1"
        JSON.parse(response.body)["error"].to_s.should contain "did not provide a valid IPv4 address "
      end
    end
  end

  context "without parameter" do
    it "returns a 422" do
      get "/v1/locate"
      response.status.should eq HTTP::Status::UNPROCESSABLE_ENTITY
    end

    it "responds with a json error" do
      get "/v1/locate"
      JSON.parse(response.body)["error"].to_s.should contain "did not provide a valid IPv4 address "
    end
  end
end
