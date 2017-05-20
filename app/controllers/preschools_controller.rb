class PreschoolsController < ApplicationController

	get '/preschools' do    
    	
	     if logged_in?

	      #@user = User.find(session[:user_id])
	      
	      @preschools = Preschool.all 
	      erb :'preschools/preschools'
	    else
	      redirect to '/'
	    end
	 end
    	

  	get '/preschools/new' do
    	 if logged_in?
      		erb :'preschools/create'
    	else
      		redirect "/login"
    	end
    end

    post '/preschools/new' do
    	
    	if params[:name] == "" || params[:address] == "" || params[:cost] == "" || params[:summary] == ""
      		redirect "preschools/new"
    	else
      		@preschool = Preschool.create(:name => params[:name], :address => params[:address],:cost => params[:cost],:summary => params[:summary])
      		
      		@preschool.user_id = current_user.id
      		@preschool.save
      		redirect to("/preschools/#{@preschool.id}")
    	end
  	end


  	get '/preschools/:id' do
    	if logged_in?
      		@preschool = Preschool.find(params[:id])
      		@user = User.find(@preschool.user_id)
      		erb :'preschools/show'
    	else
      		redirect "/login"
    	end
  	end

  	get '/preschools/:id/edit' do
	     if logged_in?
      		@preschool = Preschool.find_by_id(params[:id])
      		@user = User.find(current_user.id)
      		if @preschool.user_id == current_user.id
       			erb :'preschools/edit'
      		else
        		redirect to '/preschools'
      		end
    	  else
      		redirect to '/login'
    	  end

  	end

  	patch '/preschools/:id' do      
  		binding.pry
      	@preschool =  Preschool.find_by_id(params[:id])
      	if params[:name] == "" || params[:address] == "" || params[:cost] == "" || params[:summary] == ""     
        	redirect to("/preschools/#{@preschool.id}/edit")
      	else
        	@preschool.update(:name => params[:name], :address => params[:address],:cost => params[:cost],:summary => params[:summary])
	        @preschool.save
	        
    	    redirect to("/preschools/#{@preschool.id}")
      	end
  	end

  	delete '/preschools/:id/delete' do #delete action     
     	if logged_in?
      		@preschool = Preschool.find_by_id(params[:id])
      		if @preschool.user_id == current_user.id
        		@preschool.delete
       		 	redirect to '/preschools'
      		else
        		redirect to '/preschools'
      		end
    	else
      		redirect to '/login'
    	end
  	end

 

  	

end