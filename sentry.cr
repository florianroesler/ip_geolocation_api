require "sentry"

sentry = Sentry::ProcessRunner.new(
    display_name: "IP Geolocation API",
    build_command: "crystal build ./src/api.cr -o ./bin/api",
    run_command: "./bin/api",
    files: ["./src/*.cr"]
)

sentry.run
