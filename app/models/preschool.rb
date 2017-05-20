class Preschool <ActiveRecord::Base
	belongs_to :user

	def self.valid_params?(params)
	    return !params[:name].empty? && !params[:address].empty? && !params[:cost].empty? && !params[:summary].empty?
  	end


end
