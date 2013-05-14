class Advanced_search < ActiveRecord::Base
  
  def self.search_by_name(name_list)
    person_size = name_list.size
    predicate = "("
    name_list.each_with_index do |name, index|
		concat = false
      if(name['fname']!="")
			predicate += "(p.fname =\'" + name['fname'] + "\'"
			puts "Fname is true"
			concat = true
		end
		
      if(name['mname']!="" and concat==true)
			predicate += "and p.mname =\'" + name['mname'] + "\'" 
			concat = true 
		
		elsif(name['mname']!="")
			predicate += "(p.mname =\'" + name['mname'] + "\'"
			concat = true
		end
	
		if(name['lname']!="" and concat==true)
			predicate += "and p.lname =\'" + name['lname'] + "\'" 	
			concat = true
		elsif(name['lname']!="")
			predicate += "(p.lname =\'" + name['lname'] + "\'"
			concat = true
		end
		
		if(name['director']==true and concat==true)
			predicate += "and r.role_name = \'director\' " 	
			concat = true
		elsif(name['director']==true)
			predicate += " r.role_name = \'director\' " 	
			concat = true
		end
		
		if(name['actor']==true and concat==true)
			predicate += "and r.role_name = \'actor\'" 	
			concat = true
		elsif(name['actor']==true)
			predicate += " r.role_name = \'actor\'" 	
			concat = true
		end
        
      if(index < name_list.length-1) then predicate += ") or" end
        
      if(index == name_list.length-1 && predicate.length > 0) then predicate += ")" end
    end
    
    if(predicate[predicate.length - 4, predicate.length] == "and ") then 
      predicate = predicate[0, predicate.length - 4] 
    end

    if(predicate.length > 1) then
      predicate += ")"
      Movie.find_by_sql [
        "select dt.id, dt.name from (select m.id, m.name, p.fname from movies m, persons p, roles r where m.id = 
        r.mid and r.pid = p.id and m.name is not null and m.name <>'' and " + predicate + ") dt group by dt.id, dt.name
          having count(*) = ?", name_list.length
      ]
    else
      []
    end
  end
  
  
  def self.search_by_movie(movie)
    predicate = "("
    if(movie['movie_title']!= '') then predicate +="name = \'" + movie['movie_title'] +"\'" end
      
    if(movie['movie_year']!= '') then 
      if (predicate.length > 1) then predicate += " and " end
      predicate += " release_date = makedate(" + movie['movie_year'] + ",1)"
    end
    
    if(movie['imdb_rating']!= '') then 
      if (predicate.length > 1) then predicate += " and " end
      predicate +=" imdb_rating =" + movie['imdb_rating']
    end
  
  puts predicate
   if(predicate.length > 1) then  
      predicate += ")"
      Movie.find_by_sql [
        "select id, name from  movies where " + predicate
      ]
    else
      []
    end
  end
  
  def self.search_by_genre(genre)
    Movie.find_by_sql [
        "select m.id, m.name from movies m, classifieds c, genres g where m.id = c.mid and g.id=c.gid and 
        g.category like ?", '%'<<genre['genre_category']<<'%'
      ]
  end
  
  def self.search_by_oscar(oscar)
     
     predicate = ''
     if(oscar['start_year'] != '' || oscar['end_year'] != '') then
        predicate = "where "
        if(oscar['start_year'] != '') then predicate += "dt.release_date >= makedate(" + oscar['start_year'] +
         ",1)"
          if(oscar['end_year'] != '') then predicate +=  " and dt.release_date <= makedate(" + oscar['end_year'] +
            ",1)" end
        else
          predicate +=  "dt.release_date <= makedate(" + oscar['end_year'] +
            ",1)" 
        end
      end
    if(predicate != '') then
        Movie.find_by_sql [
           "select dt.id, dt.name from
           ((select m.id, m.name, m.release_date from movies m, oscars o, 
           p_nominated pn where m.id = pn.mid and pn.oid=o.id and o.category like ?)
           union
           (select m.id, m.name, m.release_date from movies m, oscars o, m_nominated mn 
           where m.id = mn.mid and mn.oid=o.id and o.category like ?)) dt " + predicate,
            '%'<<oscar['oscar_category']<<'%', '%'<<oscar['oscar_category']<<'%'
        ]
      else
         Movie.find_by_sql [
             "select dt.id, dt.name from
             ((select m.id, m.name from movies m, oscars o, 
             p_nominated pn where m.id = pn.mid and pn.oid=o.id and o.category like ?)
             union
             (select m.id, m.name from movies m, oscars o, m_nominated mn 
             where m.id = mn.mid and mn.oid=o.id and o.category like ?)) dt 
              ",
              '%'<<oscar['oscar_category']<<'%', '%'<<oscar['oscar_category']<<'%'
            ]
      end
   end
   
   def self.find_genre_oscar(mid)
		s
   end
  
end