# pellect.io web frontend

TBD

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

#### RAILS 5.1 (RC2)

	gem install rails -v 5.1.0.rc2 --no-document

	rails new saas-starter-app --webpack=react --skip-turbolinks --no-rc --database=postgresql
