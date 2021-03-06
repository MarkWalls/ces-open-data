# CES Open Data Project
Working on a data format and visualization tools to help Portland's Community Environmental Services publish open data.

## Dependencies
* [Ruby](https://www.ruby-lang.org/en/installation/)
* [Bundler](http://bundler.io/)
* [MongoDB](http://docs.mongodb.org/manual/installation/)

## Install
1. fork & clone repository
2. `bundle install`
3. If not on windows add shotgun: sudo gem install shotgun

## Run
1. run `shotgun app.rb` (or on windows run `ruby app.rb` - shotgun does not work on windows: https://github.com/rtomayko/shotgun/issues/40)
2. visit [http://localhost:9393/](http://localhost:9393/)

## Documentation
* [Site](docs/site.md)
* [API](docs/api.md)
