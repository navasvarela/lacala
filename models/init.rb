require_relative 'seed_pages'

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
  String :text
  String :image_file
  String :price
end


class Page < Sequel::Model
  plugin :json_serializer
end

class Menu < Sequel::Model
	one_to_many :menuitems
	plugin :json_serializer
end

class MenuItem < Sequel::Model
	many_to_one :menu
	plugin :json_serializer
end

class Dish < Sequel::Model
  plugin :json_serializer
end

if DB[:pages].empty?
  seed_pages DB[:pages]
end  
