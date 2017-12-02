# pellect.io web frontend

RAILS 5.1 based web-frontend for pellect.io

## Dependencies

Before generating your application, you will need:

- Ruby 2.4.1
- Rails 5.1.0 (RC2 for now)

## Gems

The list of all the Gems (non-Rails) this app uses.

#### Design

* [high_voltage](https://github.com/thoughtbot/high_voltage) – shortcut for adding static pages like “About”
* [font-awesome-rails](https://github.com/bokmann/font-awesome-rails) - provides the Font-Awesome web fonts and stylesheets as a Rails engine for use with the asset pipeline.
* [Google Fonts Lato](https://fonts.google.com/specimen/Lato)

#### Running and Deployment

* [Figaro](https://github.com/laserlemon/figaro) - for handling application configuration

#### Mailing Lists

* [Gibbon](https://github.com/amro/gibbon) - API wrapper for MailChimp

#### Background Processing

* [Sucker Punch](https://github.com/brandonhilkert/sucker_punch) - queuing for background jobs


## Deployment

### Local

Use Vagrant to run the 'backend'

	vagrant up
	vagrant ssh
	docker start pgsql
	exit

Start the app

	foreman start

### Heroku

Log in to the Heroku account

	heroku login

Add the Heroku remote repository

	heroku git:remote -a <app_name>

Before the first deployment

	figaro heroku:set -e production -a <app_name>

Add Heroku Resources

	heroku addons:create heroku-redis:hobby-dev -a <app_name>

Deploy the application

	git commit -am "make it better"
	git push heroku master


### How the App was built

#### Prerequisites

	gem update --system 2.6.11
	gem install bundler --no-document
	gem install nokogiri -- --with-xml2-include=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/libxml2 --use-system-libraries --no-document

#### RAILS 5.1

	gem install rails -v 5.1.0 --no-document

	rails new saas-starter-app --webpack=react --skip-turbolinks --no-rc --database=postgresql


docker run -d -e GA_PROPERTY_ID='UA-86850607-1' -e SECRET_KEY_BASE='494b8d5f1400d8143efb37aa11945ad9f04d863bec808d9d052b881ddc47ec2516b4ee62d0d402e5d133cf3c0527813a3dcfacf33c6600d80d70b99eee9387c7' -e FB_APP_ID="147721255272694" -e RAILS_ENV="development" -e RACK_ENV="development" -p 5000:5000 ratchetcc/pellectio-web