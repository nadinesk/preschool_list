class FiguresController < ApplicationController

  get '/signup' do
    if !session[:user_id]
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

  get '/preschools' do    
    
    if session[:user_id]
      @preschool = Preschool.all 
      erb :'preschools/preschools'
    else
      redirect to '/login'
    end
  end

  get "/login" do
    if session[:user_id]
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
    erb :'tweets/show_tweet'
  end



  
end
