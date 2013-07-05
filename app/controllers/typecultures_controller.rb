class TypeculturesController < ApplicationController
  skip_before_filter :login_required, :only => :index # for raw data acces
  before_filter :edit_access,
                :only => [:update, :destroy]
                
  # GET /typecultures
  # GET /typecultures.xml
  def index
    session[:set_cache_all_typecultures] = nil
    @typecultures = Typeculture.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @typecultures }
      format.json  { render :json => @typecultures }
    end
  end

  # GET /typecultures/1
  # GET /typecultures/1.xml
  def show
    @saison = Saison.find(current_saison_id)
    @typeculture = Typeculture.find(params[:id])
    @typecultures = Typeculture.all
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @typeculture }
    end
  end

  # GET /typecultures/new
  # GET /typecultures/new.xml
  def new
    @typeculture = Typeculture.new
    @typecultures = Typeculture.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @typeculture }
    end
  end

  # GET /typecultures/1/edit
  def edit
    @typeculture = Typeculture.find(params[:id])
    @typecultures = Typeculture.all
  end

  # POST /typecultures
  # POST /typecultures.xml
  def create
    @typeculture = Typeculture.new(params[:typeculture])

    respond_to do |format|
      if @typeculture.save
        flash[:notice] = 'Typeculture was successfully created.'
        format.html { redirect_to(typecultures_url) }
        format.xml  { render :xml => @typeculture, :status => :created, :location => @typeculture }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @typeculture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /typecultures/1
  # PUT /typecultures/1.xml
  def update
    @typeculture = Typeculture.find(params[:id])

    respond_to do |format|
      if @typeculture.update_attributes(params[:typeculture])
        flash[:notice] = 'Typeculture mis a jour!.'
        format.html { redirect_to(typecultures_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @typeculture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /typecultures/1
  # DELETE /typecultures/1.xml
  def destroy
    @typeculture = Typeculture.find(params[:id])
    name = @typeculture.name

    respond_to do |format|
      if (@typeculture.parcelles.size == 0)
        @typeculture.destroy
        flash[:notice] = 'le type de culture "'+ name +'" a ete supprime.'
        format.html { redirect_to(typecultures_url) }
        format.xml  { head :ok }
      else
        flash[:error] = 'Impossible de supprimer, "'+ name +'"est lie a des parcelles.'
        format.html { redirect_to(typecultures_url) }
        format.xml  { render :xml => @typeculture.errors, :status => :unprocessable_entity }
      end
    end
  end

  def set_cache
    @typeculture = Typeculture.find(params[:id])
    @saison = Saison.find(current_saison_id)
    # sum_charges
    record          = Hash.new
    record[:record] = @template.calculate_marge_by_cat_for_typeculture(@typeculture)
    record[:valid]  = true
    @saison.sum_charges[:typeculture][@typeculture.code.to_sym] = record
    # sum_produits
    record          = Hash.new
    record[:record] = @template.calculate_produit_by_cat_for_typeculture(@typeculture)
    record[:valid]  = true
    @saison.sum_produits[:typeculture][@typeculture.code.to_sym] = record
    
    respond_to do |format|
      if (@saison.save)
        flash[:notice] = 'mise en cache ok'
        format.html { redirect_to(typecultures_url) }
        format.xml  { head :ok }
      else
        flash[:error] = 'Erreur de mise en cache'
        format.html { redirect_to(typecultures_url) }
        format.xml  { render :xml => @saison.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # ok en local mais timeout sur heroku
  def set_cache_all
    @saison       = Saison.find(current_saison_id)
    typecultures = []
    @typecultures = Typeculture.find(:all).each {|c| typecultures << c }
    puts "session #{session[:set_cache_all_typecultures]}"
    
    # first element
    if session[:set_cache_all_typecultures].nil?
      puts "DEBUG : session[:set_cache_all_typecultures].nil?"
      session[:set_cache_all_typecultures] = 0
    # last element
    elsif session[:set_cache_all_typecultures].eql?(typecultures.size-1)
      puts "DEBUG : session[:set_cache_all_typecultures].eql?(typecultures.size-1)"
      session[:set_cache_all_typecultures] = nil
      done = true
    # next element
    else
      puts "DEBUG : session[:set_cache_all_typecultures]+=1"
      session[:set_cache_all_typecultures] += 1
    end
    unless done
      typeculture = typecultures.at(session[:set_cache_all_typecultures])
      # sum_charges
      record          = Hash.new
      record[:record] = @template.calculate_marge_by_cat_for_typeculture(typeculture)
      record[:valid]  = true
      @saison.sum_charges[:typeculture][typeculture.code.to_sym] = record
      # sum_produits
      record          = Hash.new
      record[:record] = @template.calculate_produit_by_cat_for_typeculture(typeculture)
      record[:valid]  = true
      @saison.sum_produits[:typeculture][typeculture.code.to_sym] = record
    
      @saison.save
    end
    respond_to do |format|
      if (done)
        flash[:notice] = 'mise en cache de tout : ok'
        format.html { redirect_to(typecultures_url) }
        format.xml  { head :ok }
      else
        puts "redirect"
        format.html { redirect_to :controller => :typecultures, :action => :set_cache_all}
        format.xml  { render :xml => @saison.errors, :status => :unprocessable_entity }
      end
    end
  end

end
