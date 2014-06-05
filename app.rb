#! /usr/bin/env ruby -w

require "redis"
require "sinatra"

redis = Redis.new
redis.set("mykey", "lalala")

get '/' do
    erb :index
end

get '/add' do
    erb :form
end

post '/add' do
    redis.set('blaa', params[:name])
end

get '/:cat' do | cat |
    # /machines
end

get '/:cat/:instance' do | cat, inst |
    # /machines/fileserver
end
