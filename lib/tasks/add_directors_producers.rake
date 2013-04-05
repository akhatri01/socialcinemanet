require 'csv'

namespace :parse do
  desc "Add directors/producers records in roles table"
  task :add_director_csv => [:environment] do
     start_idx = ENV["START_IDX"] ? ENV["START_IDX"].to_i : nil
      end_idx = ENV["END_IDX"] ? ENV["END_IDX"].to_i : nil
      puts "Starting to read CSV (WILL take some time so make sure internet stays on)"
      csv = CSV.read('lib/data/directors.csv', :encoding => 'windows-1251:utf-8', :col_sep => "\t")
    csv.each_with_index do |row, idx|
      if row[3] and row[3].split[0]=="Ignore"
        puts "Found Ingore --------------"
      end
      print row
      break if idx == 100
      puts
      
      #puts row[1]
    end
  end
end

    
  
=begin  
   
   doc = Nokogiri::XML(f)
    
    count = 1
    # reading through each node containing information about the name
    doc.xpath("//film").each do |node|
      data = Nokogiri::XML(node.to_s)
      pname = data.xpath('//pname').text
      dname = data.xpath('//dirn').text
      year = data.xpath('//year').text
      film = data.xpath('//t').text
      puts "Film => #{data.xpath('//t').text}"
      puts "Producer  => #{pname}"
      puts "Director => #{dname}"
      puts "Year => #{year}"
      puts "Next Record -------------------------------------"
    end
  end
end

=end
  
