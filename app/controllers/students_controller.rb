class StudentsController < ApplicationController
  	
	before_filter :confirm_admin || :confirm_worker, :except => [:edit,:update,:password_edit,:password_update]
	
	
	def index
		list
		render('list')
	end
			
  	
  	def list    		
  		
		case
			when params[:id]
        		conditions = ['id = ?',params[:id]]
        		@sorted = true        	
		 	when params[:role_id]
        		conditions = ['role_id = ?',params[:role_id]]
        		@sorted = false  
        	when params[:faculty_id]
        		conditions = ['faculty_id = ?',params[:faculty_id]]
    			@sorted = true
     		when params[:department_id]
       			conditions = ['department_id = ?',params[:department_id]]
       			@sorted = true
       		when params[:specialty_id]
   				conditions = ['specialty_id = ?',params[:specialty_id]]
   				@sorted = true
   			when params[:specialty_group_id]
   				conditions = ['specialty_group_id = ?',params[:specialty_group_id]]
   				@sorted = true  
   			when params[:current_year]
   				conditions = ['current_year = ?',params[:current_year]]
   				@sorted = true 			
   			when params[:day_time]
   				conditions = ['day_time = ? AND role_id = 3',params[:day_time]]
   				@sorted = true
   			when params[:active]
   				conditions = ['active = ?',params[:active]]
   				@sorted = true
   			when params[:user][:surname]
        		conditions = ['surname LIKE ? AND role_id = 3','%' + params[:user][:surname]+ '%']
        		@sorted = true
     	end		
     	
     	@total_amount = User.all(:conditions => conditions).size
     	
     	@users = User.paginate :page => params[:page],:per_page => 10, :conditions => conditions, :order => 'surname'  
  	
  	end

  	def show
  		@user = User.find(params[:user_id])
  		#@book_loans = @user.book_loans
  		
  	end
  	
  	def new
  		  		
  		@user = User.new(:role_id => 3)
  		@faculties = Faculty.sorted
  		@departments = Department.all
  		@specialties = Specialty.all
  		@groups = SpecialtyGroup.all
  	end

	def create
		#@faculties = Faculty.all		
		#@departments = Department.all
  		#@specialties = Specialty.all
  		
		#if params[:user][:password] == params[:user][:password_confirmation]
			@user = User.new(:role_id => params[:user][:role_id],:name => params[:user][:name],:surname => params[:user][:surname],
					:username => params[:user][:username],:card_code => params[:user][:card_code],:faculty_id => params[:user][:faculty_id],
					:department_id => params[:user][:department_id],:specialty_id => params[:user][:specialty_id],
					:specialty_group_id => params[:user][:specialty_group_id],:current_year => params[:user][:current_year],
					:email => params[:user][:email],:day_time => params[:user][:day_time],:password => "123456789")
			#@user = User.new(params[:user],params[:user_spec])
		#else
			#render('new')
		#end
		
		if @user.save
			flash[:notice] = "Student successfully created"
			redirect_to(:action => 'list',:faculty_id => params[:user][:faculty_id])
		else			
			flash[:notice] = @user.errors.full_messages
			render('new')
		end
	end
	
  	def edit  		
  		
  		@faculties = Faculty.sorted
  		@departments = Department.all
  		@specialties = Specialty.all
  		@groups = SpecialtyGroup.all
  		@user = User.find(params[:user_id])
  	end
  	
  	def update
  		@user = User.find_by_username(params[:user][:username])
  				
  		if params[:user][:password] == params[:user][:password_confirmation]			
  				 #attributes = { "city"=>{"city_prices_attributes"=>{"6"=> {"price"=>"", "id"=> soap.id.to_s}, "4"=> {"price"=>"", "id"=> beer.id.to_s},}}}
  				 if @user.update_attributes(params[:user]) 
  				
  					flash[:notice] = 'The student has been updated!.'  
  					redirect_to(:action => 'list',:id => @user.id)	  					
  				else
  					flash[:notice] = 'The student couldn\'t be updated!.'
  					render('edit')
  				end 
  		else		
  			flash[:notice] =  @user.errors.full_messages
  			render('edit')
  		end
  	end
  	
  	
  	
  	
  	
  	def destroy
  		@user = User.find_by_id(params[:user_id])
  		@user.destroy
  		redirect_to(:action => 'list', :role_id => 3)
  	end
  	
  	def update_departments  		
  		faculty = Faculty.find(params[:id])
  		departments = faculty.departments
  		specialties = faculty.specialties
  		#groups = faculty.groups
  		
  		
  		render :update do |page|
  			page.replace_html 'departments', :partial => 'shared/departments', :object => departments
  			page.replace_html 'specialties', :partial => 'shared/specialties', :object => specialties
  			#page.replace_html 'groups', :partial => 'shared/groups', :object => groups
		end 		
  		
  	end
  	
  	def update_specialties
  		department = Department.find(params[:id])
  		specialties = department.specialties
  		
  		
  		render :update do |page|
  			page.replace_html 'specialties', :partial => 'shared/specialties', :object => specialties
  			#page.replace_html 'groups', :partial => 'shared/groups', :object => groups
  		end
  	end		
  	
  	def update_groups
  		specialty = Specialty.find(params[:id])
  		groups = specialty.specialty_groups
  		
  		render :update do |page|
  			page.replace_html 'groups', :partial => 'shared/groups', :object => groups
  		end	
  	end
 	
  	
end


