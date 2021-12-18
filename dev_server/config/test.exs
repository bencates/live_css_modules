import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dev_server, DevServerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "ySdJIdfONTmLzhTrJJywSav+0RwamWUeARLleF4JMTvnRzV0Uys2eSQipPteXx0G",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
