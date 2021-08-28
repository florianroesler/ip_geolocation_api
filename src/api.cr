require "kemal"
require "http/client"
require "log"

ENV["IP_DATA_PATH"] =  "lib/ip_geolocation/spec/fixtures/excerpt.zip"

require "./routes"

Kemal.run
