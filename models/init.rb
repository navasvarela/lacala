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
  String :description
  String :
  String :image_file
end


DB.create_table? :dishes do
  primary_key :id
  String :section
  String :title
  String :text
  String :image_file
end