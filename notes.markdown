users
- schools

user has many schools
school belongs to user

* Config.ru
  * look at fwitter and playlister/nyc project
* Gemfile
  * look at fwitter and playlister/nyc project
* Rakefile
* README.md
* LICENSE.md
* Gemfile.lock
* CONTRIBUTING.md
* .rspec
* config (folder)
  * environment.rb
* db
* App
  * Models
      * Users
      * schools
  * Views
      * index.erb
      * users(folder)
          * login.erb
          * signup.erb
      * preschools(folder)
          * new.erb
          * edit.erb
          * show.erb
          * preschools.erb          
  * Controllers
          * Application_controller
          * user_controller
          * school_controller


Steps:
* Create user table (rake db:create_migration NAME=users)
  * username
  * password
  * email
* Create preschool table (rake db:create_migration NAME=users)
  * name
  * address
  * cost
  * summary


  class Users < ActiveRecord::Migration
  	def change
    	create_table :users do |t|
    		t.text :username
    		t.text :email
    		t.string :password_digest


    	end

    end
  end



    class Preschools < ActiveRecord::Migration
    	def change
      	create_table :preschools do |t|
      		t.string :name
      		t.text :address
      		t.integer :cost
          t.text :summary
      	end

      end
    end

####

class User < ActiveRecord::Base

  has_many :preschools

   has_secure_password

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)    
    User.all.find{|a|  a.slug == slug }
  end

end


########
class Preschool <ActiveRecord::Base
	belongs_to :user

end

#####
