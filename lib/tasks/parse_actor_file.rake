require 'csv'

namespace :parse do
  desc "Parse given actors_csv file"
  
  # run 'rake parse:actors_csv
  task :actors_csv => :environment do
    puts "Starting to read CSV (may take some time)"
    csv = CSV.read('lib/data/Actors_Names.csv', :encoding => 'windows-1251:utf-8')
    puts "File read, now doing work on each row"
    persons = []
    csv.each do |row|
      /(\w*),\s(\w*)(\s(\w*))*/ =~ row[1]
      persons.push({'fname' => ($2 || ''), 'mname' => ($4 || ''), 'lname' => $1})
    end
    puts persons
  end
end