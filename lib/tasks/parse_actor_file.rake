require 'csv'
require 'open-uri'

@tmdb_search = "http://private-68e6-themoviedb.apiary.io/3/search/person?api_key=87c41d34aef9b780524821b0ef5afe91&query="
@tmdb_get_person = lambda{|id| "http://private-68e6-themoviedb.apiary.io/3/person/#{id}?api_key=87c41d34aef9b780524821b0ef5afe91"}

# uses the api from : http://docs.themoviedb.apiary.io/
# Steps:
#   1  Query for the actor name
#      - if there is more than 1 result, actor wasn't found
#   2  Get the id from the result
#   3  Use the id to find the person
#   4  Return resulting json object
private
def tmdb_find_person (fname, mname, lname)
  if fname.length > 0 && mname.length > 0 && lname.length > 0 
    search_json = JSON.parse(open(@tmdb_search + "#{fname}+#{mname}+#{lname}").read)
  elsif fname.length > 0 && mname.length == 0 && lname.length > 0 
    search_json = JSON.parse(open(@tmdb_search + "#{fname}+#{lname}").read)
  else
    search_json = JSON.parse(open(@tmdb_search + "#{lname}").read)
  end
  if search_json["total_results"] == 1
    tmdb_id = search_json["results"][0]["id"]
    return JSON.parse(open(@tmdb_get_person.call(tmdb_id)).read)
  else
    return nil
  end
end

namespace :parse do
  
  desc "Parse given actors_csv file (options: START_IDX)."
  # run 'rake parse:actors_csv
  task :actors_csv => :environment do
    start_idx = ENV["START_IDX"].to_i || nil
    puts "Starting to read CSV (WILL take some time so make sure internet stays on)"
    csv = CSV.read('lib/data/Actors_Names.csv', :encoding => 'windows-1251:utf-8')
    puts "File read, now doing work on each row, inserting into the database"
    csv.each_with_index do |row, idx|
      next if idx == 0
      if start_idx then if idx < start_idx then next end end
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
        tmdb_person = tmdb_find_person(fname, mname, lname)
        if tmdb_person
          p.dob = tmdb_person["birthday"]
          p.save
        end
        sleep(0.25) # adding sleep because of 30 requests per 10 sec limit
      rescue ActiveRecord::RecordNotUnique
        puts row[1]
        puts "duplicate record (not inserting): #{fname} #{mname} #{lname}"
      rescue OpenURI::HTTPError
        puts "Curr_name: #{fullname}. Error connecting to tmdb, continuing to next row."
        next
      end
    end
  end
end