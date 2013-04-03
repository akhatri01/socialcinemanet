require 'csv'

namespace :parse do
  
  desc "Parse given ratings csv file (options: START_IDX, END_IDX)."
  # run 'rake parse:add_ratings
  task :add_ratings => :environment do
    start_idx = ENV["START_IDX"] ? ENV["START_IDX"].to_i : nil
    end_idx = ENV["END_IDX"] ? ENV["END_IDX"].to_i : nil
    puts "File read, now doing work on each row, inserting into the database"
    num_successful = 0
    File.open('lib/data/ratings.list.csv', 'r') do |f|
      f.each_with_index do |line, idx|
        if idx % 1000 == 0 then puts "Successful inserts so far: #{num_successful} / #{idx}" end
        next if idx == 0 
        if start_idx != nil then if idx < start_idx then next end end
        if end_idx != nil then if idx > end_idx then next end end
        begin
          next if /{.+}/.match line
          next if /\".+\"/.match line
          /((\d.\d)|(\d\d)),\s+
           (([a-zA-Z\d]*'?[-a-zA-Z\d]*)(\s+([a-zA-Z\d]*'?[-a-zA-Z\d]*))*)
           \((\d\d\d\d)\)/x =~ line
        rescue Exception
          puts $!
          puts line, idx
          next
        end
        rating = $2.to_f
        begin
          m_name = $4.to_ascii.downcase.chop
        rescue Exception
          next
        end
        year = $8.to_i
        m = Movie.where('LOWER(name)=? AND release_date BETWEEN ? AND ?', m_name, "#{year}-01-01", "#{year}-12-31")
        if m.length == 1     # found movie
          m = m[0]
          m.imdb_rating = rating
          m.save
          num_successful += 1
        else
          # create new movie b/c it was not found
          begin
            m = Movie.create(name: m_name, release_date: DateTime.strptime(year.to_s, "%Y"), imdb_rating: rating)
            num_successful += 1
          rescue ActiveRecord::RecordNotUnique
            puts "duplicate record (not inserting): #{m_name}"
            next
          end
        end
      end
    end
    puts "\n\n\nNumber of successful inserts:"
    puts num_successful
  end
end