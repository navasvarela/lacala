DB = Sequel.connect('sqlite://lacala.db')

# Creates table pages if it doesn't exists already
DB.create_table? :pages do
  primary_key :id
  String :section
  String :title
  String :text
  String :image_file
end