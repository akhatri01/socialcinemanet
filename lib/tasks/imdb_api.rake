namespace :parse do
  
  desc "Using imdb_api to add more movie information."
  # run 'rake parse:add_ratings
  task :imdb_api => :environment do
    puts "Beginning"
    total_cnt = Movie.where("name is not null and name <> ''").count
    used_cnts = {}
    cnt = rand(total_cnt)
    used_cnts[cnt] = ''
    while (cnt < total_cnt) 
      Movie.where("name is not null and name <> ''").offset(cnt).limit(1).each do |movie|
        puts movie.name
        /([a-zA-Z\d]*(\s[-a-zA-Z\d]*)*)(\s\((.+)\))*/ =~ movie.name
        if !$1 then next end
        movie_name = $1.strip || movie.name
        imdb_search = Imdb::Search.new(movie_name).movies.each do |imdb|
          /([a-zA-Z\d]*(\s[-a-zA-Z\d]*)*)\s\((\d\d\d\d)\)/ =~ imdb.title
          if !$1 and !$3 then next end 
          if $1.strip.downcase == movie_name && $3.to_i == movie.release_date.year
            movie.imdb_url = imdb.url
            movie.poster_url = imdb.poster
            movie.imdb_rating = imdb.rating
            movie.plot = imdb.plot
            movie.length = imdb.length
            movie.save
            puts 'saved id=' + movie.id.to_s
            break
          end
        end
      end
      while used_cnts.has_key?(cnt)
        cnt = rand(total_cnt)
      end
      used_cnts[cnt] = ''
    end
    # Movie.where("name is not null and name <> ''").all.each do |movie|
    # end
  end
end