class MoviesController < ApplicationController
  
  # GET /movies
  # GET /movies.json
  def index
    # @movies = Movie.where('id > ? AND imdb_rating > 0', 50000).find(:all, :limit => 20)
    
    @sort_by = params[:sort_by] || 'name'
    
    if @sort_by == 'imdb_rating'
      movie_count = Movie.where("name <> '' AND name IS NOT null AND imdb_rating IS NOT null").count
    # elsif @sort_by == 'user_rating' || @sort_by == 'user_rating_number'
    #   movie_count = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM aggregate_u_ratings_for_movies").first[0] 
    else
      movie_count = Movie.where("name <> '' AND name IS NOT null").count
    end
    @max_pages = (movie_count / 20) + 1
    
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

  # GET /movies/1
  # GET /movies/1.json
  def show
    @movie = Movie.find(params[:id])
	  @m_oscar = Movie.m_oscar(params[:id])
	  @p_oscar = Movie.p_oscar(params[:id])
	  @genre = Movie.find(params[:id]).genre
	  @movie_crew = Movie.find(params[:id]).persons
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movie }
    end
  end
  
  def rate
    @movie = Movie.find(params[:id])
    urating = URating.where("uid = ? AND mid = ?", @current_user.id, params[:id].to_i).first
    if !urating
      urating = URating.new
      urating.rating = params[:rating].to_f
      urating.mid = params[:id].to_i
      urating.uid = @current_user.id
      urating.save
      ActiveRecord::Base.connection.execute "UPDATE movies m LEFT JOIN (SELECT mid, AVG(rating) as average, COUNT(rating) as cnt FROM u_ratings u WHERE u.mid = " + urating.mid.to_s + " GROUP BY mid) res ON res.mid = m.id SET user_rating=res.average, user_rating_count=res.cnt WHERE m.id=" + urating.mid.to_s
    else
      urating.rating = params[:rating].to_f
      urating.save
      ActiveRecord::Base.connection.execute "UPDATE movies m LEFT JOIN (SELECT mid, AVG(rating) as average, COUNT(rating) as cnt FROM u_ratings u WHERE u.mid = " + urating.mid.to_s + " GROUP BY mid) res ON res.mid = m.id SET user_rating=res.average, user_rating_count=res.cnt WHERE m.id=" + urating.mid.to_s
    end
    render :partial => 'movies/movie', :locals => {:movie => @movie}
  end

  # GET /movies/new
  # GET /movies/new.json
  def new
    @movie = Movie.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @movie }
    end
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(params[:movie])

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render json: @movie, status: :created, location: @movie }
      else
        format.html { render action: "new" }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1
  # PUT /movies/1.json
  def update
    @movie = Movie.find(params[:id])

    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to movies_url }
      format.json { head :no_content }
    end
  end
end
