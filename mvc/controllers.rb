require 'bcrypt'


def createu(params)
  @user ||= User.new
  pass = BCrypt::Password.create(params[:password].to_s, :cost => 5)
  params[:password] = pass
  @user.attributes = params
  if @user.save
    return true
  else
    @user.errors.each do |e|
      puts e
      # aqui debe de ahcer algo, quizás retornar un 
      # diccionario con los errores
    end
  end
end

def check_pass(user, pass)
  @user = User.first(:username => user)
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

#TODO faltan los métodos de actualización de usuarios

def createm(params)
  @msg = Message.new
  @msg.nick = params[:nick]
  @msg.msg = params[:msg]
  @msg.created_at = Time.now

  if @msg.save
    return true
  else
    @msg.errors.each do |e|
      puts e
      # aqui debe de ahcer algo, quizás retornar un 
      # diccionario con los errores
    end
  end
end
  
def export_file
  mensajes = Message.all
  f1 = File.new("salida.txt", "w")
  mensajes.each do |m|
    f1.puts "[" + m.created_at.to_s + "] " + m.nick + ": " + m.msg
  end
  f1.close
  return true
end
#  
#  def to_xml(desde, hasta = Time.now)
#  end
#end
#    # Crea un nuevo fichero, y escribe
#    File.open('text.txt', 'w') do |f2|
#      # '\n' es el retorno de carro
#      f2.puts "Por que la vida \n puede ser maravillosa"
#    end

#        ------------------------------
#      # abriendo los ficheros
#      fentrada=File.new "entrada.txt","r"
#      fsalida=File.new("salida.txt","w")

#      #leemos una linea en la variable linea que será alfanumvrica
#      linea=fentrada.gets         

#      #bucle de lectura/escritura hasta que linea==nil
#      until linea==nil
#       # escribiendo en salida.txt  
#       fsalida.puts linea

#       #leyendo en linea
#       linea=fentrada.gets
#      end
#      #Cerrando ficheros.
#      fentrada.close
#      fsalida.close
#      ------------------------------
