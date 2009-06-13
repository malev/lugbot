require 'rubygems'
require 'dm-core' # instead of 'datamapper'
require 'dm-validations'

# A Sqlite3 connection to a database file:
DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/test.db")
DataObjects::Sqlite3.logger = DataObjects::Logger.new("log/dm.log", 0)
DataObjects::Sqlite3.logger = DataObjects::Logger.new(STDOUT, 0)

# For production!!!
#DataMapper::Logger.new("log/error.log", :error) # :off, :fatal, :error, :warn, :info, :debug
#DataMapper::Logger.new("log/fatal.log", :fatal) # :off, :fatal, :error, :warn, :info, :debug

class Message
  include DataMapper::Resource
  property  :id,            Serial         
  property  :body,          Text
  property  :created_at,    DateTime
# Associations
  belongs_to :user
end

class User
  include DataMapper::Resource
  property  :id,            Serial
  property  :username,      String
  property  :email,         String
  property  :pass_hashed,   String
  property  :pass_salt,     String
  property  :type,          Integer, :default => 0
# Validations
  validates_present :username, :message => "Debe ingresar un nombre de usuario."
  validates_present :pass_hashed, :message => "Debe ingresar una contraseña."
  validates_is_unique :username, :message => "Lo siento, ya hay un usuario con ese nombre."
  validates_format :email, :format => :email_address, :messages => {
                                    :presence => "Falta el correo",
                                    :format => "Debe ser un correo"}
# Associations
  has n, :messages
end

DataMapper.auto_upgrade!