# auto-require anything listed in the Gemfile
require 'bundler'
Bundler.require(:default)

Mongoid.load!("config/mongoid.yml")

require 'sinatra/json'

# auto-require anything in /lib
Dir.glob("lib/*") { |file| require_relative file }

if production?
  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    username == ENV['BASIC_USER'] and password == ENV['BASIC_PASS']
  end
end

get '/' do
  erb :index
end

get '/samples' do
  @js = ['samples']
  erb :samples
end

get '/submit/?' do
  erb :submit
end

post '/submit' do
  Parser.parse(params['file'][:filename], params['file'][:tempfile])
end


get '/api/:version/samples.?:format?' do
  @samples = Sample.all
  json @samples
end


#http://localhost:4567/api/v0/search/zip/97213
get '/api/:version/search/zip/:zip' do
	#For getting the information about a zipcode as of the most recent date we have					
		return "Zip by closest date to current time: " + params[:zip] + " at " + DateTime.now.strftime('%a %d %b %Y') 
end


#http://localhost:4567/api/v0/search/zip/97213/daterange?datestart=%221-1-2014%22&dateend=%222-1-2014%22
get '/api/:version/search/zip/:zip/daterange' do
	#For getting the information about a zipcode within a daterange					
		return "Zip by date range: " + DateTime.parse(params[:datestart]).strftime('%a %d %b %Y')  + " to " + DateTime.parse(params[:dateend]).strftime('%a %d %b %Y') 
end

#http://localhost:4567/api/v0/search/zip/97213/vs/97045
get '/api/:version/search/zip/:zipA/vs/:zipB' do
	#For getting a comparison between two zip codes using the most up to date info
	return "ZipCode " + params[:zipA] + " vs " + params[:zipB]
end

#http://localhost:4567/api/v0/search/zip/97213/vs/97045/daterange?datestart=%221-1-2014%22&dateend=%222-1-2014%22
get '/api/:version/search/zip/:zipA/vs/:zipB/daterange' do
	#For getting a comparison between two zip codes using a date range
	return "ZipCode " + params[:zipA] + " vs " + params[:zipB] + " in daterange" + DateTime.parse(params[:datestart]).strftime('%a %d %b %Y')  + " to " + DateTime.parse(params[:dateend]).strftime('%a %d %b %Y') 
end

