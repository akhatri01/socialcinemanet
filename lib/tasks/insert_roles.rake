require 'nokogiri'

namespace :parse do
  desc "Import movie database from csv file"
  task :role_xml => [:environment] do
    
    #opening file
    puts 'Opening file, it may take some time'
    f = File.open('lib/data/imdb.xml')
    doc = Nokogiri::XML(f)
  
    ctr = 1
    # reading the nodes into a hashtable 
    puts "Creating the hash and updating the nodes, takes a while"
    h = Hash.new
    doc.xpath("//node").each do |node| 
      # if ctr > 25000 && ctr < 1300000 
      #   ctr += 1
      #   next
      # end
      #puts node.xpath("//node/data[@key='k0']")
      id = node.values[0]
      parsed = Nokogiri::XML(node.to_s).xpath("//data")
      val1 = parsed.first.text
      val2 = nil
      if parsed[2]
        val2 = parsed[2].text
        h[id] = [val1, val2]
      else
        h[id] = [val1]
      end
      puts ctr
      ctr += 1
    end
    
    puts "Done creating Hash!!!!!!!!!"
    
    count = 1
   
    #inserting into the role table now
    puts "Inserting  records into the ROLES tables now"
    doc.xpath("//edge").each do |node|
      node1 =  node.values[0]
      node2 = node.values[1]
            #puts "#{node1} #{node2}"
      
    begin
        # find if node exist
       if(h.include?(node1) and h.include?(node2))
           # find which node is person and which one is movie
          if(node1 >= "n0" and node1 <= "n428439")
            movie = h[node1]
            person = h[node2]
          else
            movie = h[node2]
            person = h[node1]
          end
          
          #puts "#{person}, #{movie}"

          #find first name, last name and movie name
          pname = person[0].split(',')
          if(pname.length >= 2)
            lname = pname[0].strip
            fname = pname[1].strip
          else
            fname = ""
            lname = pname[0].strip
          end
          mname = movie[0].strip.downcase
          myear = movie[1].strip
          
          # Create into Role table
          if (!Person.find_by_fname_and_lname(fname, lname).nil? and !Movie.where('LOWER(name)=? AND release_date BETWEEN ? AND ?', mname, "#{myear}-01-01", "#{myear}-12-31").nil?)
            begin
              #puts "YOu are here"
              ppid = Person.find_by_fname_and_lname(fname, lname).id
              # mmid = Movie.find_by_name(mname).id
              m = Movie.where('LOWER(name)=? AND release_date BETWEEN ? AND ?', mname, "#{myear}-01-01", "#{myear}-12-31")
              if m.length == 1     # found movie
                mmid = m[0].id
              else
                # movie not found, move on
                next
              end
              Role.create(mid: mmid, pid: ppid, role_name: 'actor')
              puts "#{count} Row Inserted"
              count += 1

            rescue ActiveRecord::RecordNotUnique
              puts "duplicate record (not inserting): #{ppid}"
            end
          end
        end
    rescue Exception => e
        puts e.message
      end
      end

      f.close()
    end
  end




   
