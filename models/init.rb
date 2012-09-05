require_relative 'seed_pages'
require_relative 'seed_dishes'

# Add json serializer plugin to all models
Sequel::Model.plugin :json_serializer

DB = Sequel.connect('sqlite://lacala.db')

# Creates table pages if it doesn't exists already
DB.create_table? :pages do
  primary_key :id
  String :section
  String :title
  String :text
  String :image_file
end

DB.create_table? :menus do
  primary_key :id
  String :name
  String :category
  Integer :price
  DateTime :modified
end

DB.create_table? :menuitems do
  primary_key :id
  foreign_key :menu_id, :menus
  foreign_key :dish_id, :dishes
  String :description
  String :name
  String :image_file
end


DB.create_table? :dishes do
  primary_key :id
  String :section
  String :title
  String :short_desc
  String :text
  String :image_file
  String :price
end

# Custom module
# JSON serializer does not parse very well JSON

module JSONParser 
  def parse_json(json)
    JSON.parse(json).each { | key,value| self[key] = value }
  end
end

Sequel::Model.include JSONParser

class Page < Sequel::Model
  
end

class Menu < Sequel::Model
	one_to_many :menuitems
	
end

class MenuItem < Sequel::Model
	many_to_one :menu
	one_to_one :dishes
end

class Dish < Sequel::Model
  
end


if DB[:pages].empty?
  seed_pages DB[:pages]
end  

if DB[:dishes].empty?
  seed_dishes DB[:dishes]
end
