class FiguresController < ApplicationController

  get '/signup' do
    if !session[:user_id]
      erb :'users/signup'
    else
      redirect to '/preschools'
    end
  end

  get '/preschools' do
    if session[:user_id]
      @preschools = Preschool.all
      erb :'preschool/preschools'
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


end
