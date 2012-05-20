class StatisticsController < ApplicationController
  
	before_filter :confirm_admin
	#before_filter :clean_apriori_combinations,:except => [:list]
		
	def index
		list
		render('list')
	end
	
	def list
		@faculties = Faculty.all
		@departments = Department.all
		@specialties = Specialty.all
		@statistics = Statistic.all
  	end
  	
  	def show
  		  		
  		conditions = ['id > 0']
		
		@loans = BookLoan.all
		
		
		#Getting needed transaction
		@statistic = Statistic.find(params[:stat_id])
		@users = []
		
		#Filtering all loans by user id
		@loans.each do |loan|
			@user = User.find_by_id(loan.user_id)
			#Excludes users by their properties		
			if @user.faculty_id == @statistic.faculty_id &&
					@user.department_id == @statistic.department_id && 
						@user.specialty_id == @statistic.specialty_id &&
							@user.current_year == @statistic.current_year
				@users << @user unless @users.include?(@user)
			end
		end				
		
		@transaction_array = []
		@user_transactions = Hash.new		
		# Getting all transactions together
		@users.each do |user|
			@loans.each do |loan|
				if user.id == loan.user_id
					@transaction_array << loan.book_id
				end
			end
			#Associating transactions to its user
			@user_transactions[user] =  @transaction_array
			@transaction_array = []
		end	
		
		@books = Book.all
		
		@support = @statistic.support
		
		@good_singles = []		
		@results_hash = Hash.new	#Keeps all combinations with their supports				
		@amount = 0		
		
		@books.each do |book|
			@user_transactions.each do |user,user_transaction|	
				#Checks if book exists in transaction			
				if user_transaction.include?(book.id)
						@amount += 1											
				end
			end	
			@combination_array = Array.new([book.id])					
			@results_hash[@combination_array] = @amount #(@amount.to_f / @user_transactions.size.to_f * 100.0).to_i						
			@amount = 0					
		end
		
		#Separate combinations that fulfil required support
		@results_hash.each do |combination,supp|
			if supp >= @support				
				@good_singles << combination
			end
		end							
		
		@available = true
		#Variable remembers last combination size
		@last_checked_combination_size = 1
		while(@available)
			@results_hash = combination_creator(@results_hash,@good_singles,@support)
			@available = false
			@results_hash.each do |combination,_support|
				if combination.size >= @last_checked_combination_size
					if _support >= @support
						@available = true					
					end
				end
			end		
			@last_checked_combination_size += 1	
		end
		
		
		@stat_present =  AprioriCombination.find_by_statistic_id(params[:stat_id])		
		
		if @stat_present.blank?
			@results_hash.each do |combination,support|			
				@statistic.apriori_combinations << AprioriCombination.new(:statistic_id => params[:stat_id],:combination => combination, :support => support )
			end
		end
		
		conditions = ['statistic_id = ?',params[:stat_id]]
		@apriori_results = AprioriCombination.paginate :page => params[:page],:per_page => 15, :conditions => conditions
				
		
  	end   	
  	
  	def combination_creator(results_hash,good_singles,support)
  		@temp_array = []
  		results_hash.each do |present_combination,_support|			 
			if _support >= @support
				0.upto(good_singles.size - 1) do |j|
					if !present_combination.include?(good_singles[j][0]) 
						combination_array = Array.new(present_combination + good_singles[j])							
						@temp_num = -1
						0.upto(combination_array.size - 1) do |i|
							(i+1).upto(combination_array.size - 1) do |j|
								if combination_array[i].to_i > combination_array[j].to_i
									@temp_num = combination_array[i]
									combination_array[i] = combination_array[j]
									combination_array[j] = @temp_num
								end
							end
						end
						
						if !@temp_array.include?(combination_array)
							@temp_array << combination_array						
						end
					end					
				end
			end		
		end
		all_present = 0
		
		@temp_array.each do |combination|
			@user_transactions.each do |user,user_transaction|
				all_present = 0	
				0.upto(combination.size - 1) do |j|						
					if user_transaction.include?(combination[j])
						all_present += 1
					else																						
						break
					end
				end
				if combination.size == all_present
					@amount += 1					
				end							
			end				
			@results_hash[combination] = @amount 
			@amount = 0				
		end
		
		return results_hash
  	end
  	
  	
  	def new
  		@stat = Statistic.new(params[:stat])
  		if @stat.save
  			redirect_to(:action => 'list',:stat_id => params)
  		else
  			flash[:notice] = @stat.errors.full_messages
  			render('list')
  		end
  	end		
  	
  	def delete
  		@stat = Statistic.find(params[:stat_id])
  		@stat.destroy
  		redirect_to(:action =>'list')
  	end
  	
  	def update_departments  		
  		faculty = Faculty.find(params[:id])
  		departments = faculty.departments
  		specialties = faculty.specialties
  		
  		render :update do |page|
  			page.replace_html 'departments', :partial => 'shared/departments', :object => departments
  			page.replace_html 'specialties', :partial => 'shared/specialties', :object => specialties
  		end 		
  		
  	end
  	
  	def update_specialties
  		department = Department.find(params[:id])
  		specialties = department.specialties
  		
  		render :update do |page|
  			page.replace_html 'specialties', :partial => 'shared/specialties', :object => specialties
  		end
  	end		
  	
  	def clean_apriori_combinations
  		@ap_combinations = AprioriCombination.find(params[:stat_id])
  		if !@ap_combinations.blank?
  			@ap_combinations.destroy 		
  		end
  	end 

	def book_values
		@stat = AprioriCombination.find(params[:combination_id])
		
		
	end
	
end
