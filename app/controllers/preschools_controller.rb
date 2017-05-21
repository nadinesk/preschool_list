class PreschoolsController < ApplicationController

	get '/preschools' do        	
	     redirect_if_not_logged_in
	      @preschools = Preschool.all 
	      erb :'preschools/preschools'
	    
	 end
    	

  	get '/preschools/new' do
    	redirect_if_not_logged_in
      @error_message = params[:error]
      erb :'preschools/create'    	
    end

    get '/preschools/:id/edit' do
         redirect_if_not_logged_in
        @error_message = params[:error]
        @preschool = Preschool.find_by_id(params[:id])
        @user = User.find(current_user.id)
        erb :'preschools/edit'
    end

     post '/preschools/new' do
      redirect_if_not_logged_in
      unless Preschool.valid_params?(params)
        redirect "/preschools/new?error=invalid preschool entry"
      end
          @preschool = Preschool.create(:name => params[:name], :address => params[:address],:cost => params[:cost],:summary => params[:summary])
          
          @preschool.user_id = current_user.id
          @preschool.save
          redirect to("/preschools/#{@preschool.id}")
      
    end

    patch '/preschools/:id' do            
        redirect_if_not_logged_in
        @preschool =  Preschool.find_by_id(params[:id])
        unless Preschool.valid_params?(params)
          redirect "/preschools/#{@preschool.id}/edit?error=invalid preschool entry"
        end
       
        @preschool.update(:name => params[:name], :address => params[:address],:cost => params[:cost],:summary => params[:summary])
        @preschool.save
          
        redirect to("/preschools/#{@preschool.id}")
        
    end

    get '/preschools/:id' do
      redirect_if_not_logged_in
      @preschool = Preschool.find(params[:id])
      @user = User.find(@preschool.user_id)
      erb :'preschools/show'
    end


  	get '/preschools/:id' do
    	redirect_if_not_logged_in
      		@preschool = Preschool.find(params[:id])
      		@user = User.find(@preschool.user_id)
      		erb :'preschools/show'    	
  	end

  	delete '/preschools/:id/delete' do #delete action     
     	redirect_if_not_logged_in
      		@preschool = Preschool.find_by_id(params[:id])
      		
        	redirect to '/preschools'
      		
  	end

end