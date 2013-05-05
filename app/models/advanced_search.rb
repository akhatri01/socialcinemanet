class Advanced_search < ActiveRecord::Base
  
  def self.search_by_name(name_list)
    person_size = name_list.size
    predicate = ""
    name_list.each_with_index do |name, index|
      if(name['fname']!="") then predicate += "(fname =\'" + name['fname'] + "\'" end
      if(name['mname']!="") then predicate += "and mname =\'" + name['mname'] + "\'" end
      if(name['lname']!="") then predicate += "and lname =\'" + name['lname'] + "\'" end
        
      if(index < name_list.length-1) then predicate += ") or" end
        
      if(index == name_list.length-1 && predicate.length > 0) then predicate += ")" end
    end
    
    if(predicate[predicate.length - 4, predicate.length] == "and ") then 
      predicate = predicate[0, predicate.length - 4] 
    end

    if(predicate.length > 0) then
      Movie.find_by_sql [
        "select dt.id, dt.name from (select m.id, m.name, p.fname from movies m, persons p, roles r where m.id = 
        r.mid and r.pid = p.id and m.name is not null and m.name <>'' and " + predicate + ") dt group by dt.id, dt.name
          having count(*) = ?", name_list.length
      ]
    else
      nil
    end
    
  end
  
end