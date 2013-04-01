require 'csv'

namespace :parse do
  desc "Parse given actors_csv file"
  
  # run 'rake parse:actors_csv
  task :actors_csv => :environment do
    puts "Starting to read CSV (may take some time)"
    csv = CSV.read('lib/data/Actors_Names.csv', :encoding => 'windows-1251:utf-8')
    puts "File read, now doing work on each row, inserting into the database"
    csv.each_with_index do |row, idx|
      next if idx == 0
      fullname = row[1].to_ascii.downcase.tr('.', '')
      /([a-zA-Z\d]*'?[-a-zA-Z\d]*)
       (,\s([a-zA-Z\d]*'?[-a-zA-Z\d]*)(\s([a-zA-Z\d]*'?[-a-zA-Z\d]*))*
       (,\s([a-zA-Z\d]*'?[-a-zA-Z\d]*))*)*/ =~ fullname
      fname = $3 ? $3 : ''
      mname = $5 ? $5 : ''
      lname = $1 ? $1 : ''
      begin
        Person.create(fname: fname, mname: mname, lname: lname)
      rescue ActiveRecord::RecordNotUnique
        puts row[1]
        puts "duplicate record (not inserting): #{fname} #{mname} #{lname}"
      end
      # puts idx+1
    end
  end
end