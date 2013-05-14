class InfoController < ApplicationController
  
  def index
    
    sort_by = params[:sort_by] || 'user_rating'
    
    @movies = Movie.find_by_sql ["select id, name, release_date, user_rating, user_rating_count
                                  from movies order by " + sort_by + " desc limit 20"
                                ]
    
    @top_users = ActiveRecord::Base.connection.execute "select * from ( select uid, count(1) as count_rate 
                          from u_ratings where updated_at BETWEEN 
                          DATE_SUB(LAST_DAY(DATE_SUB(NOW(), INTERVAL 1 MONTH)),INTERVAL DAY(LAST_DAY(DATE_SUB(NOW(), INTERVAL 1 MONTH)))-1 DAY)
                           AND LAST_DAY(DATE_SUB(NOW(), INTERVAL 1 MONTH)) 
                          group by uid) dt order by dt.count_rate desc limit 3"
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
    @movie_person_flag = false
    @movie_flag = false
    @genre_flag = false
    @oscar_flag = false
	#@person_list = []
	
	@search_criteria = ''
    
    params["movie_persons"].each_with_index  do |person, index|
      if(person["fname"]!="" || person["mname"] !="" || person["lname"]!="") then
        @movie_person_flag = true
		if (person['lname']!='') then @search_criteria += " lname: "+person['lname'] end
		if (person['mname']!='') then @search_criteria += " mname: "+person['mname'] end
		if (person['fname']!='') then @search_criteria += " fname: "+person['fname'] end
		if (person['director']==true) then @search_criteria += " as Director " end
		if (person['actor']==true) then @search_criteria += " as Actor " end
      end
    end
    
	movie = params["movie"]
    if(movie['movie_title']!='' || movie['movie_year']!='' || movie['imdb_rating']!='' || movie['user_rating']!='') then
      @movie_flag = true
	  if (movie['movie_title']!='') then @search_criteria += " movie_title: " + movie['movie_title'] end
	  if (movie['movie_year']!='') then @search_criteria += " movie_year: " + movie['movie_year'] end
	  if (movie['imdb_rating']!='') then @search_criteria += " imdb_rating: " + movie['imdb_rating'] end
    end
    
    if(params["genre"]['genre_category']!='') then
      @genre_flag = true
	  @search_criteria += " genre: " + params["genre"]['genre_category']
    end
    
    oscar = params["oscar"]
    if(oscar['oscar_category']!='' || oscar['start_year']!='' || oscar['end_year']!='') then
      @oscar_flag = true
	  if(oscar['oscar_category']!='') then @search_criteria += " oscar: " + oscar['oscar_category'] end
	  if(oscar['start_year']!='') then @search_criteria += " oscar_start_year: " + oscar['start_year'] end
	  if(oscar['end_year']!='') then @search_criteria += " oscar_end_year: " + oscar['end_year'] end
	  
    end
    
    # puts movie_person_flag
    # puts movie_flag
    # puts genre_flag
    # puts oscar_flag
    
    if(@movie_person_flag) then
      @advanced_movie_person_result = Advanced_search.search_by_name(params["movie_persons"])
    else
      @advanced_movie_person_result = []
    end
    
    if(@movie_flag) then
      @advanced_movie_result = Advanced_search.search_by_movie(params["movie"])
    else
      @advanced_movie_result = []
    end
    
    if(@genre_flag) then
      @advanced_movie_genre_result = Advanced_search.search_by_genre(params["genre"])
    else
      @advanced_movie_genre_result = []
    end
    
     if(@oscar_flag) then
        @advanced_movie_oscar_result = Advanced_search.search_by_oscar(params["oscar"])
      else
        @advanced_movie_oscar_result = []
      end
    
    # @fname = params["movie_persons"].length
    
    @result = @advanced_movie_person_result | @advanced_movie_result | @advanced_movie_genre_result | @advanced_movie_oscar_result
    
    if(@movie_person_flag) then @result = @result & @advanced_movie_person_result end
    if(@movie_flag) then @result = @result & @advanced_movie_result end
    if(@genre_flag) then @result = @result & @advanced_movie_genre_result end
    if(@oscar_flag) then @result = @result & @advanced_movie_oscar_result end
      
      
    render :partial => "advanced_search_result"
  end
  
  def rate_it
    # while (@movie = Movie.where("name is not null and name <> ''").offset(rand(Movie.count)).first) == nil
    #   next
    # end
    while (@movie = Movie.offset(rand(Movie.where("name is not null and name <> '' and imdb_url is not null").count)).first) == nil
      next
    end
	
	@m_oscar = @movie.movie_oscars
	@p_oscar = @movie.person_oscars
	@genre = @movie.genre
	@movie_crew = @movie.persons
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
	m_oscar = Movie.find(params[:id]).movie_oscars
	p_oscar = Movie.find(params[:id]).person_oscars
	genre = Movie.find(params[:id]).genre
	movie_crew = Movie.find(params[:id]).persons
    
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
    render :partial => 'movies/movie', :locals => {:movie => movie, :m_oscar => m_oscar, :p_oscar => p_oscar, :genre => genre, :movie_crew => movie_crew}
  end
  
  def ajax_imdb_global_update
    imdb_url = params[:imdb_url]
    /tt(\d+)/ =~ imdb_url
    if !$1
      return render :text => 'false'
    else 
      imdb_movie = Imdb::Movie.new($1)
      if !imdb_movie
        return render :text => 'false'
      else
        movie = Movie.find_by_name (imdb_movie.title)
        if !movie
          movie = Movie.new
          movie.name = imdb_movie.title
        end
        movie.imdb_url = imdb_url
        movie.poster_url = imdb_movie.poster
        movie.imdb_rating = imdb_movie.rating
        movie.plot = imdb_movie.plot
        movie.release_date = DateTime.strptime(imdb_movie.year.to_s, "%Y")
        if movie.save
          return render :text => movie.id.to_s
        else
          return render :text => 'false'
        end
      end
    end
  end

end