require 'datos'

class UsersController
  def new
    @user = User.new
  end
  
  def create(params)
    @post ||= User.new
    @post.attributes = params
    if @post.save
      return
    else
      @post.errors.each do |e|
        puts e
        # aqui debe de ahcer algo, quizás retornar un 
        # diccionario con los errores
      end
    end 
  end
end