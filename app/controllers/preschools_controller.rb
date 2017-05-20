class PreschoolsController < ApplicationController

	get '/preschools' do    
    	binding.pry
	    if session[:user_id]
	      @preschools = Preschool.all 
	      erb :'preschools/preschools'
	    else
	      redirect to '/login'
	    end
	 end
    
	get '/users/:slug' do
		if session[:user_id]      		
			
      		@user = User.find_by_slug(params[:slug])
      		binding.pry
      		@preschool = Preschool.find_by(:user_id => @user.id)      
      		erb :'preschools/user_preschools'
    	else
      		redirect "/login"
    	end
    	erb :'preschools/user_preschools'
  	end

  	get '/preschools/new' do
    	if session[:user_id]
      		erb :'preschools/create'
    	else
      		redirect "/login"
    	end
    end

    post '/preschools/new' do
    	binding.pry
    	if params[:name] == "" || params[:address] == "" || params[:cost] == "" || params[:summary] == ""
      		redirect "preschools/new"
    	else
      		@preschool = Preschool.create(:name => params[:name], :address => params[:address],:cost => params[:cost],:summary => params[:summary])
      		@preschool.user_id = session[:user_id]
      		@preschool.save
      		redirect to("/preschools/#{@preschool.id}")
    	end
  	end


  	get '/preschools/:id' do
    	if session[:user_id]
      		@preschool = Preschool.find(params[:id])
      		@user = User.find(@preschool.user_id)
      		binding.pry
      
      		erb :'preschools/show'
    	else
      		redirect "/login"
    	end
  	end

  	get '/preschools/:id/edit' do
	    if session[:user_id]
	      @preschool = Preschool.find(params[:id])
	      @user = User.find(@preschool.user_id)
	      erb :'preschools/edit'
	    else
	      
	      redirect "/login"
	    end

  	end

  	patch '/preschools/:id' do      
      	@preschool =  Preschool.find_by_id(params[:id])
      	if params[:name] == "" || params[:address] == "" || params[:cost] == "" || params[:summary] == ""     
        	redirect to("/preschools/#{@preschool.id}/edit")
      	else
        	@preschools.update(:name => params[:name], :address => params[:address],:cost => params[:cost],:summary => params[:summary])
	        @preschool.save

    	    redirect to("/preschools/#{@preschool.id}")
      	end
  	end

  	delete '/preschools/:id/delete' do #delete action     
     	@preschool = Preschool.find_by_id(params[:id])
     	if session[:user_id] == @preschool.user_id      
      		@preschool.delete
      		redirect to '/preschools'
     	else
      		redirect to '/login'
     	end   
  	end

  	

end