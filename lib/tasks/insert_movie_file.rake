require 'csv'

namespace :parse do
desc "Import movie database from csv file"
task :movie_genre_classified_csv => [:environment] do

  #file = "lib/data/dvd_data.csv"
  start_idx = ENV["START_IDX"].to_i || nil
  puts "Starting to read CSV (WILL take some time)"
  csv = CSV.read('lib/data/dvd_data.csv', :encoding => 'windows-1251:utf-8')
  puts "File read, now doing work on each row, inserting into the database"
  csv.each_with_index do |row, idx|
    next if idx == 0
    
    # inserting into genre table
     begin
        g = Genre.create(category: row[9])

      rescue ActiveRecord::RecordNotUnique
        puts row[9]
        puts "duplicate record (not inserting): #{row[9]}"
      end
    
    row[8] =~ /(\d\d\d\d)/ 
    next if not $1
    begin
      #puts "#{row[8]} #{row[9]}"
      m = Movie.create(name: row[0], release_date: DateTime.strptime(row[8], "%Y"))
      
      c= Classified.create(mid: m.id, gid: Genre.find_by_category(row[9]).id)
      
      
      #for checking only, remove break later
      #break
    rescue ActiveRecord::RecordNotUnique
      puts row[1]
      puts "duplicate record (not inserting): #{row[1]}"
    end

  end
end
end