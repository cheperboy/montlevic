# migration

if rvm is used:
	bundle exec rake db:migrate

else
	rake db:migrate


## migrate up
	bundle exec rake db:migrate:up VERSION=X --trace
	