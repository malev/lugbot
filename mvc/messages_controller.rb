require 'datos'

class MessagesController
  def new
    @msg = Message.new
  end
  
  def create(params)
    @msg ||= Message.new
    @msg.attributes = params
    if @msg.save
      return
    else
      @msg.errors.each do |e|
        puts e
        # aqui debe de ahcer algo, quizás retornar un 
        # diccionario con los errores
      end
    end 
  end
