class GenresController < ApplicationController
  # GET /genres
  # GET /genres.json
  def index
    @genres = Genre.all
    @genres_movie_counts = {}
    @genres.each_with_index do |genre, idx|
      @genres_movie_counts[idx] = genre.movies.count
    end
    @genres_movie_counts = @genres_movie_counts.sort_by do |key, val| val end .reverse

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @genres }
    end
  end

  # GET /genres/1
  # GET /genres/1.json
  def show
    @genre = Genre.find(params[:id])
    @genre_movie_count = @genre.movies.count
    @max_pages = (@genre_movie_count / 20) + 1
    
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
    
    @movies = @genre.movies.offset((@idx-1)*20).limit(20)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @genre }
    end
  end

  # GET /genres/new
  # GET /genres/new.json
  def new
    @genre = Genre.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @genre }
    end
  end

  # GET /genres/1/edit
  def edit
    @genre = Genre.find(params[:id])
  end

  # POST /genres
  # POST /genres.json
  def create
    @genre = Genre.new(params[:genre])

    respond_to do |format|
      if @genre.save
        format.html { redirect_to @genre, notice: 'Genre was successfully created.' }
        format.json { render json: @genre, status: :created, location: @genre }
      else
        format.html { render action: "new" }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /genres/1
  # PUT /genres/1.json
  def update
    @genre = Genre.find(params[:id])

    respond_to do |format|
      if @genre.update_attributes(params[:genre])
        format.html { redirect_to @genre, notice: 'Genre was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /genres/1
  # DELETE /genres/1.json
  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy

    respond_to do |format|
      format.html { redirect_to genres_url }
      format.json { head :no_content }
    end
  end
end
