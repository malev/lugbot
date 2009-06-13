require 'datos'
require 'openssl'
require 'digest/sha1'

class UsersController
  def new
    @user = User.new
  end
  
  def create(params)
    @user ||= User.new
    @user.attributes = params
    if @user.save
      return
    else
      @user.errors.each do |e|
        puts e
        # aqui debe de ahcer algo, quizás retornar un 
        # diccionario con los errores
      end
    end 
  end

  def valid_user(username, pass)
    @user = User.get(:username => username)
    # hay que ver de un sistema de encriptación
    # de pass
    if @user.pass_hashed = pass
      return @user
    else
      return @user = nil
    end    
  end

  def encrypt_pass(pass)
    salt = (0...8).map{65.+(rand(25)).chr}.join
    pass = pass + salt 
    c = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
    c.encrypt
    # your pass is what is used to encrypt/decrypt
    c.key = key = Digest::SHA1.hexdigest(pass)
    c.iv = iv = c.random_iv
    e = c.update("crypt this")
    e << c.final
    return {:pass_hashed => e, :salt => salt}
  end    
end