# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_montlevic_session',
  :secret      => '6cff025bb1fbcf20f249a9389916be978331d2a17923c9692dc8e50d79237b5bab7847d120a9ea657a31916cd69229b6054b7e3d0ea69f9288b8f589590683e4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
