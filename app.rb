#! /usr/bin/env ruby -w

require "sqlite3"
require "sinatra"

class MBObject

  attr_reader :id, :title

  @@db = SQLite3::Database.new "membrain.db"

  def initialize
    @id = 0
    @keys = []
    @values = []
    @title = ""
  end

  def init_with_row(row)
    @id = row[0]
    @title = row[1]
    @updated = row[2]
  end

  def self.create(name)
    @@db.execute("INSERT INTO objects (title, updated) VALUES (?, DATETIME())", name)
    @@db.execute("SELECT last_insert_rowid()")[0][0]
  end

  def self.all
    all = []
    @@db.execute("SELECT id, title, updated FROM objects") do | row |
      o = MBObject.new
      all << o.init_with_row(row)
    end
    return all
  end

  def self.get(id)
    o = MBObject.new
    @@db.execute("SELECT id, icon, updated FROM objects WHERE id = ?", id) do | row |
      o = MBObject.new
      o.init_with_row(row)
    end
    return o
  end

  def get_url
    "/#{@id}/edit"
  end
end

get '/' do
  @data = MBObject.all
  erb :index
end

get '/add' do
  erb :form
end

post '/add' do
  i = MBObject.create(params[:name])
  redirect "/#{i}"
end

get '/:id' do
  @data = MBObject.get(params[:id])
  erb :view_object
end

get '/:id/edit' do
  @o = MBObject.get(params[:id])
  erb :edit_object
end
