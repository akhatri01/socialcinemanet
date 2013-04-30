class InfoController < ApplicationController

  def index
    # @movies = Movie.where('id > ? AND imdb_rating > 0', 50000).find(:all, :limit => 20)
    movie_count = Movie.where("name <> '' AND name IS NOT null").count
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
    
   @sort_by = params[:sort_by] || 'name'
    
   @movies = Movie.movie_tables(@idx, @sort_by)
  end

end