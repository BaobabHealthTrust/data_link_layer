# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_data_link_layer_session',
  :secret      => '807a2a17d4007823bafde8e354410ceb8073dde7384b4e97fba36938029326bfcbce6fad5d2a9ce6a2ae70c4378d4c3c634d92ebb9b95b3a29a0a74f5e4d43df'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
