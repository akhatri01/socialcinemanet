require 'csv'
require 'open-uri'

@tmdb_search = "http://api.themoviedb.org/3/search/person?api_key=87c41d34aef9b780524821b0ef5afe91&query="
@tmdb_get_person = lambda{|id| "http://api.themoviedb.org/3/person/#{id}?api_key=87c41d34aef9b780524821b0ef5afe91"}

# uses the api from : http://docs.themoviedb.apiary.io/
# Steps:
#   1  Query for the actor name
#      - if there is more than 1 result, actor wasn't found
#   2  Get the id from the result
#   3  Use the id to find the person
#   4  Save the resulting person
private
def tmdb_find_person (p, fname, mname, lname)
  if fname.length > 0 && mname.length > 0 && lname.length > 0 
    query = "#{fname}+#{mname}+#{lname}"
  elsif fname.length > 0 && mname.length == 0 && lname.length > 0 
    query = "#{fname}+#{lname}"
  else
    query = "#{lname}"
  end
  search_json = JSON.parse(open(@tmdb_search + query).read)
  if search_json["total_results"] == 1
    tmdb_id = search_json["results"][0]["id"]
    tmdb_person = JSON.parse(open(@tmdb_get_person.call(tmdb_id)).read)
    if tmdb_person
      p.dob = tmdb_person["birthday"]
      p.save
    end
  end
end

namespace :parse do
  
  desc "Parse given actors_csv file (options: START_IDX, END_IDX)."
  # run 'rake parse:actors_csv
  task :actors_csv => :environment do
    start_idx = ENV["START_IDX"] ? ENV["START_IDX"].to_i : nil
    end_idx = ENV["END_IDX"] ? ENV["END_IDX"].to_i : nil
    puts "Starting to read CSV (WILL take some time so make sure internet stays on)"
    csv = CSV.read('lib/data/Actors_Names.csv', :encoding => 'windows-1251:utf-8')
    puts "File read, now doing work on each row, inserting into the database"
    csv.each_with_index do |row, idx|
      next if idx == 0
      if start_idx != nil then if idx < start_idx then next end end
      if end_idx != nil then if idx > end_idx then next end end
      fullname = row[1].to_ascii.downcase.tr('.', '')
      /([a-zA-Z\d]*'?[-a-zA-Z\d]*)
       (,\s([a-zA-Z\d]*'?[-a-zA-Z\d]*)(\s([a-zA-Z\d]*'?[-a-zA-Z\d]*))*
       (,\s([a-zA-Z\d]*'?[-a-zA-Z\d]*))*)*/x =~ fullname
      fname = $3 ? $3 : ''
      mname = $5 ? $5 : ''
      lname = $1 ? $1 : ''
      next if fname == '' && mname == '' && lname == ''
      begin
        p = Person.create(fname: fname, mname: mname, lname: lname)
        tmdb_person = tmdb_find_person(p, fname, mname, lname)
      rescue ActiveRecord::RecordNotUnique
        puts row[1]
        puts "duplicate record (not inserting): #{fname} #{mname} #{lname}"
      rescue OpenURI::HTTPError
        puts "Curr_name: #{fullname}. Error connecting to tmdb, continuing to next row."
        sleep(1) # adding sleep because of 30 requests per 10 sec limit
        next
      end
    end
  end
end