require 'bcrypt'

class Sessions
  def initialize(username, password, nick)  
    return nil unless check_pass(username, password)
    @expira = Time.now.to_i + 5 * 60
    @nick = nick
    @username = username
  end
  
  def disponible?
    return false unless Time.now.to_i < @expira
    true
  end
  
end  

class Usuarios
  def create(username, email, password)
    user ||= User.new
    pass = BCrypt::Password.create(password, :cost => 5)
    password = pass
    user.attributes = {:username => username, :password => pass, :email => email}
    if user.save
      return true
    else
      user.errors.each do |e|
        puts e
      end
      return false
    end
  end

  def check_pass(user, pass)
    user = User.first(:username => user)
    if user == nil
      return false
    end
    passh = BCrypt::Password.create(:password => pass, :cost => 5)
    if passh == @user.password
      return true
    else
      return false
    end
  end
end

class Mensajes
  def self.create(params)
    @msg = Message.new
    @msg.nick = params[:nick]
    @msg.msg = params[:msg]
    @msg.created_at = Time.now
    if @msg.save
      return true
    else
      @msg.errors.each do |e|
        $LOG.error e
      end
      return false
    end
    true
  end
    
  def self.export_file
    mensajes = Message.all
    f1 = File.new("salida.txt", "w")
    mensajes.each do |m|
      f1.puts "[" + m.created_at.to_s + "] " + m.nick + ": " + m.msg
    end
    f1.close
    return true
  end
end
