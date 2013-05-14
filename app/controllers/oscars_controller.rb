class OscarsController < ApplicationController
  def p_nom_winner
    @oscar = Oscar.find params[:id]
    @year = params[:year]
    @movies = Movie.find_by_sql ["(SELECT m.* FROM movies m, p_nominated p_o WHERE (p_o.oid = ? AND p_o.mid = m.id AND p_o.win = 1 AND p_o.year = ?) AND m.name IS NOT null AND m.name <> '' GROUP BY m.id ORDER BY p_o.year)", params[:id], params[:year]]
    @actors = Person.find_by_sql ["(SELECT p.* FROM persons p, p_nominated p_o WHERE (p_o.oid = ? AND p_o.pid = p.id AND p_o.win = 1 AND p_o.year = ?) GROUP BY p.id ORDER BY p_o.year)", params[:id], params[:year]]
  end
  def m_nom_winner
    @oscar = Oscar.find params[:id]
    @year = params[:year]
    @movies = Movie.find_by_sql ["(SELECT m.* FROM movies m, m_nominated m_o WHERE (m_o.oid = ? AND m_o.mid = m.id AND m_o.win = 1 AND m_o.year = ?) AND m.name IS NOT null AND m.name <> '' GROUP BY m.id ORDER BY m_o.year)", params[:id], params[:year]]
  end
  def p_nom
    @oscar = Oscar.find params[:id]
    @year = params[:year]
    @movies = Movie.find_by_sql ["(SELECT m.* FROM movies m, p_nominated p_o WHERE (p_o.oid = ? AND p_o.mid = m.id AND p_o.year = ?) AND m.name IS NOT null AND m.name <> '' GROUP BY m.id ORDER BY p_o.year)", params[:id], params[:year]]
    @actors = Person.find_by_sql ["(SELECT p.* FROM persons p, p_nominated p_o WHERE (p_o.oid = ? AND p_o.pid = p.id AND p_o.year = ?) GROUP BY p.id ORDER BY p_o.year)", params[:id], params[:year]]
  end
  def m_nom
    @oscar = Oscar.find params[:id]
    @year = params[:year]
    @movies = Movie.find_by_sql ["(SELECT m.* FROM movies m, m_nominated m_o WHERE (m_o.oid = ? AND m_o.mid = m.id AND m_o.year = ?) AND m.name IS NOT null AND m.name <> '' GROUP BY m.id ORDER BY m_o.year)", params[:id], params[:year]]
  end
  
  # GET /oscars
  # GET /oscars.json
  def index
    @oscars = Oscar.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @oscars }
    end
  end

  # GET /oscars/1
  # GET /oscars/1.json
  def show
    @oscar = Oscar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @oscar }
    end
  end

  # GET /oscars/new
  # GET /oscars/new.json
  def new
    @oscar = Oscar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @oscar }
    end
  end

  # GET /oscars/1/edit
  def edit
    @oscar = Oscar.find(params[:id])
  end

  # POST /oscars
  # POST /oscars.json
  def create
    @oscar = Oscar.new(params[:oscar])

    respond_to do |format|
      if @oscar.save
        format.html { redirect_to @oscar, notice: 'Oscar was successfully created.' }
        format.json { render json: @oscar, status: :created, location: @oscar }
      else
        format.html { render action: "new" }
        format.json { render json: @oscar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /oscars/1
  # PUT /oscars/1.json
  def update
    @oscar = Oscar.find(params[:id])

    respond_to do |format|
      if @oscar.update_attributes(params[:oscar])
        format.html { redirect_to @oscar, notice: 'Oscar was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @oscar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /oscars/1
  # DELETE /oscars/1.json
  def destroy
    @oscar = Oscar.find(params[:id])
    @oscar.destroy

    respond_to do |format|
      format.html { redirect_to oscars_url }
      format.json { head :no_content }
    end
  end
end
