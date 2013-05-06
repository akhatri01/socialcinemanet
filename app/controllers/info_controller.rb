class InfoController < ApplicationController
  
  def index
    # @movies = Movie.where('id > ? AND imdb_rating > 0', 50000).find(:all, :limit => 20)
    
    @sort_by = params[:sort_by] || 'name'
    
    if @sort_by == 'imdb_rating'
      movie_count = Movie.where("name <> '' AND name IS NOT null AND imdb_rating IS NOT null").count
    else
      movie_count = Movie.where("name <> '' AND name IS NOT null").count
    end
    @max_pages = movie_count / 20
    
    @idx = params[:idx].to_i
    @idx = @idx <= 0 ? 1 : @idx
    @idx_prev = @idx <= 1 ? nil : @idx-1
    @idx_next = @idx >= @max_pages ? nil : @idx+1
    
    if @idx <= 3 
      @page_nums = [ 1, 2, 3, 4, 5]
    elsif @idx >= @max_pages - 2
      @page_nums = [ @max_pages-4, @max_pages-3, @max_pages-2, @max_pages-1, @max_pages]
    else
      @page_nums = [ @idx - 2, @idx - 1, @idx, @idx + 1, @idx + 2]
    end
    
   @movies = Movie.movie_tables(@idx, @sort_by)
  end
  
  def search
    
    @search_val = params[:search_val] ? params[:search_val].gsub(/[^0-9a-z ]/i, '') : nil
    
    if @search_val and @search_val.strip!=""
      @movie_result = Info.search_movies(@search_val)
      @genre_result = Info.search_genres(@search_val)
      @person_result = Info.search_persons(@search_val)
      @oscar_result = Info.search_oscars(@search_val)
    else
      @movie_result = []
      @genre_result = []
      @person_result = []
      @oscar_result = []
    end
    
    
    
  end
  
  def advanced_search 
    
  end
  
  def advanced_search_result
    movie_person_flag = false
    movie_flag = false
    genre_flag = false
    oscar_flag = false
    
    params["movie_persons"].each  do |person|
      if(person["fname"]!="" || person["mname"] !="" || person["lname"]!="") then
        movie_person_flag = true
      end
    end
    
    movie = params["movie"]
    if(movie['movie_title']!='' || movie['movie_year']!='' || movie['imdb_rating']!='' || movie['user_rating']!='') then
      movie_flag = true
    end
    
    if(params["genre"]['genre_category']!='') then
      genre_flag = true
    end
    
    oscar = params["oscar"]
    if(oscar['oscar_category']!='' || oscar['start_year']!='' || oscar['end_year']!='') then
      oscar_flag = true
    end
    
    puts movie_person_flag
    # puts movie_flag
    # puts genre_flag
    # puts oscar_flag
    
    if(movie_person_flag) then
      @advanced_movie_person_result = Advanced_search.search_by_name(params["movie_persons"])
    else
      @advanced_movie_person_result = []
    end
    
    if(movie_flag) then
      @advanced_movie_result = Advanced_search.search_by_movie(params["movie"])
    else
      @advanced_movie_result = []
    end
    
    if(genre_flag) then
      @advanced_movie_genre_result = Advanced_search.search_by_genre(params["genre"])
    else
      @advanced_movie_genre_result = []
    end
    
     if(oscar_flag) then
        @advanced_movie_oscar_result = Advanced_search.search_by_oscar(params["oscar"])
      else
        @advanced_movie_oscar_result = []
      end
    
    # @fname = params["movie_persons"].length
    
    @result = @advanced_movie_person_result | @advanced_movie_result | @advanced_movie_genre_result | @advanced_movie_oscar_result
    
    if(movie_person_flag) then @result = @result & @advanced_movie_person_result end
    if(movie_flag) then @result = @result & @advanced_movie_result end
    if(genre_flag) then @result = @result & @advanced_movie_genre_result end
    if(oscar_flag) then @result = @result & @advanced_movie_oscar_result end
      
      
    render :partial => "advanced_search_result"
  end
  
  def rate_it
    while (@movie = Movie.where("name is not null and name <> ''").offset(rand(Movie.count)).first) == nil
      next
    end
    # /([a-zA-Z\d]*(\s[-a-zA-Z\d]*)*)\s\((.+)\)/ =~ @movie.name
    # movie_name = $1 || @movie.name
    # # @movie = Movie.find 279154
    # @imdb_url = nil
    # @imdb_poster = nil
    # imdb_id = nil
    # cnt = 0
    # imdb_search = Imdb::Search.new(movie_name).movies.each do |movie|
    #   /([a-zA-Z\d]*(\s[-a-zA-Z\d]*)*)\s\((\d\d\d\d)\)/ =~ movie.title
    #   if $1 == movie_name && $3.to_i == @movie.release_date.year
    #     @imdb_url = movie.url
    #     @imdb_poster = movie.poster
    #     @movie.imdb_rating = movie.rating
    #     @movie.save
    #     break
    #   end
    #   cnt += 1
    #   if cnt > 5 then break end
    # end
  end
  
  def ajax_imdb_update
    imdb_url = params[:imdb_url]
    movie = Movie.find params[:id]
    
    /tt(\d+)/ =~ imdb_url
    if !$1
      @imdb_url_not_found = true
    else 
      imdb_movie = Imdb::Movie.new($1)
      if !imdb_movie
        @imdb_url_not_found = true
      else
        movie.imdb_url = imdb_url
        movie.poster_url = imdb_movie.poster
        movie.imdb_rating = imdb_movie.rating
        movie.plot = imdb_movie.plot
        movie.release_date = DateTime.strptime(imdb_movie.year.to_s, "%Y")
        movie.save
      end
    end
    # return render :text => imdb_url
    render :partial => 'movies/movie', :locals => {:movie => movie}
  end

end