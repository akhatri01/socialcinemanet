=begin 	==================================================================	
	Author:		Amrit Khatri 
	Purpose:	Loads the directors-move database in roles table
	Date:		4-5-2012
	==================================================================
=end
	
require 'csv'

namespace :parse do
  desc "Add directors/producers records in roles table"
  task :add_director_csv => [:environment] do
     start_idx = ENV["START_IDX"] ? ENV["START_IDX"].to_i : nil
      end_idx = ENV["END_IDX"] ? ENV["END_IDX"].to_i : nil
      puts "Starting to read CSV (WILL take some time so make sure internet stays on)"
      csv = CSV.read('lib/data/directors.csv', :encoding => 'windows-1251:utf-8', :col_sep => "\t")
	  #csv = CSV.read('lib/data/Check.csv', :encoding => 'windows-1251:utf-8', :col_sep => "\t")
	  rpname = ''
	  count = 1
    csv.each_with_index do |row, idx|
	
		#compacting the row (deleting nil values from the array)
		row.compact!
	
		#Ignoring the empty lines
	  if (row.length == 0)
		#puts "Empty Line--------------------------------"
		next
	  end
	  
	# Ignoring the TV shows
      if (row[0].split[0]=="Ignore" or (row[1] and row[1].split[0]=="Ignore"))
        #puts "Found Ingore --------------"
		next
      end
	  
	  #puts row
	  #reading raw person and raw month_year name
		if(row.length > 1)
			rpname = row[0]
			rmy = row[1]		
		else
			rmy = row[0]
		end
		
		#puts "#{rpname}. #{rmy}"
		#parsing correctly the raw person name and raw movie_year name
		mname = rmy.split('(')[0]
		year = rmy[(rmy =~ /\(/) + 1, 4]
		rpname_split = rpname.split(',');
		
		#puts "You are here -----------------"
		
		if(rpname_split.length > 1)
			lname = rpname_split[0]
			fname = rpname_split[1]
			has_lname = true
		else
			fname = rpname_split[0]
			has_lname = false
		
		end
		
		#puts "#{fname} #{lname}, #{mname}, #{year}" if has_lname
		#puts "#{fname} , #{mname}, #{year}" if !has_lname
		fname.strip!
		lname.strip! if has_lname
		mname.strip!
		year.strip!
		
		#inserting in the database now
		begin
			person = nil
			if(has_lname)
				person = Person.find_by_fname_and_lname(fname, lname)
			else
				person = Person.find_by_fname(fname)
			end
			movie  = Movie.where('LOWER(name)=? AND release_date BETWEEN ? AND ?', mname, "#{year}-01-01", "#{year}-12-31")
			
			if(!person.nil? and !movie.nil?)
				begin
					#puts "YOu are here"
					ppid = person.id
					if movie.length == 1     # found movie
						mmid = movie[0].id
					else
						# movie not found, move on
						next
					end
					Role.create(mid: mmid, pid: ppid, role_name: 'director')
					puts "#{count} Row Inserted out of #{idx} reads"
					count += 1
	
				rescue ActiveRecord::RecordNotUnique
					puts "duplicate record (not inserting): #{ppid}"
				end
				
			end
		rescue Exception =>e
			puts "#{e}"
		end
      break if idx >= 100000
      #puts
      
      #puts row[1]
    end
end
end


