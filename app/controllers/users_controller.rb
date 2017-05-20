class UsersController < ApplicationController

  get '/signup' do

    if !logged_in?

      erb :'users/signup'
    else
      redirect to '/preschools'
    end
  end

   post '/signup' do
    
    if params[:username] == "" || params[:password] == "" || params[:email] == ""    
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])         
      @user.save
      session[:user_id] = @user.id
      redirect to '/preschools'
    end
    
  end
 get "/login" do
    if logged_in?
      redirect "/preschools"
    else
      erb :'users/login'
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])      
      session[:user_id] = user.id
      redirect "/preschools"
    else
      redirect "/signup"
    end
  end

  get "/logout" do
    if session[:user_id]
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

  get '/users/:slug' do
    binding.pry
    @user = User.find_by_slug(params[:slug])          
    @preschool = Preschool.find_by(:user_id => @user.id)      
    if session[:user_id] && (session[:user_id] == @user.id)
        binding.pry  
          erb :'preschools/user_preschools'
      else

          redirect "/login"
      end
      
    end

 

  
end
