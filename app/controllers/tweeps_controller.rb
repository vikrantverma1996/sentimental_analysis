class TweepsController < ApplicationController
  require 'twitter'

  before_action :set_tweep, only: [:show, :edit, :update, :destroy]

  # GET /tweeps
  # GET /tweeps.json
        
  def get_tweet_sentiment tweet,ob
    
        # create TextBlob object of passed tweet text
        analysis = Sentimental.new
        analysis.load_defaults
        puts "iiiiiiiiiiiiiiiiiiiii"
        x=analysis.score tweet
        puts x
      if  x > 0.25
          ob['p']=ob['p']+1
      elsif x< -0.25
        ob['n']=ob['n']+1
      else
 
        ob['ne']=ob['ne']+1
      end 
        puts "ssentoiiiiii"
        return  analysis.sentiment tweet
            
     
     
end
     

  def index
   @ob={}
    @ob['p']=0
    @ob['n']=0
    @ob['ne']=0
    @tweeps = Tweep.all
    if @tweeps.last!=nil

        
    @client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "cWyKKMvMaVOoXnHr3oYLIWYvv"
    config.consumer_secret     = "fjyWEqKy8wN91xJmfZgcibX6FHn7wxhEJ1STv0UatnLeaD9j9Q"
    config.access_token        = "956937190549811205-9baQu4duMt5EykFnHv9x1AeM3KOH1cA"
    config.access_token_secret = "yUmzSNKuQzS72U0e3E4VzNwWqXA1q6ieaSIsoxIiqoYzi"
  end
  @tweet=[]
  @client.search(@tweeps.last.query, result_type: "recent").take(10).collect do |tweet|
   t=tweet.text
    obj={}
    obj['text']=t
    obj['sentiment']=  get_tweet_sentiment t,@ob
    @tweet<<obj
    puts "ssssssssssssssssssss"
    puts @ob['p']
    puts @ob['n']
    puts @ob['ne']

  end 
end
  end

  # GET /tweeps/1
  # GET /tweeps/1.json
  def show

  end

  # GET /tweeps/new
  def new
    @tweep = Tweep.new
  end

  # GET /tweeps/1/edit
  def edit
  end

  # POST /tweeps
  # POST /tweeps.json
  def create
    @tweep = Tweep.new(tweep_params)

    respond_to do |format|
      if @tweep.save
        format.html { redirect_to tweeps_url, notice: "sentiment analysis of the keyword '#{@tweep.query}'" }
        format.json { render :show, status: :created, location: @tweep }
      else
        format.html { render :new }
        format.json { render json: @tweep.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweeps/1
  # PATCH/PUT /tweeps/1.json
  def update
    respond_to do |format|
      if @tweep.update(tweep_params)
        format.html { redirect_to @tweep, notice: 'Tweep was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweep }
      else
        format.html { render :edit }
        format.json { render json: @tweep.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweeps/1
  # DELETE /tweeps/1.json
  def destroy
    @tweep.destroy
    respond_to do |format|
      format.html { redirect_to tweeps_url, notice: 'Tweep was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweep
      @tweep = Tweep.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweep_params
      params.require(:tweep).permit(:query)
    end
end
