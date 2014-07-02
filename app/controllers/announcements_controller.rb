class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show,:fetch]

  # GET /announcements
  # GET /announcements.json
  def index
    @announcements = Announcement.all.page(params[:page])
    
  	if( params[:find] )
  	  @default_news = Announcement.find(params[:find])  		
  	else	
  		@default_news = Announcement.first
  	end  	

  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
  end

  def fetch
	   respond_to do |format|
       format.js
     end     
  end
  
   private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

end
