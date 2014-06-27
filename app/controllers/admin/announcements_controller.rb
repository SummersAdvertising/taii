#encoding: utf-8
class Admin::AnnouncementsController < AdminController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]

  # GET /announcements
  # GET /announcements.json
  def index
    @announcements = Announcement.all
  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
  end

  # GET /announcements/new
  def new
    @announcement = Announcement.create()
  	@announcement.article = Article.new
  	@announcement.title = "最新消息標題#{Time.now.strftime("%Y-%m-%d-%I")}"
		
    respond_to do |format|
      if @announcement.save
        format.html { redirect_to edit_admin_announcement_path(@announcement), notice: 'Announcement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @announcement }
      else
        format.html { render action: 'new' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /announcements/1/edit
  def edit
  end

  # POST /announcements
  # POST /announcements.json
  def create
    @announcement = Announcement.new(announcement_params)

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to @announcement, notice: 'Announcement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @announcement }
      else
        format.html { render action: 'new' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /announcements/1
  # PATCH/PUT /announcements/1.json
  def update
    respond_to do |format|
      if @announcement.update(announcement_params) && ( params[ :article ].nil? ^ @announcement.article.update( params.require(:article).permit(:content) ) )
      
        format.html { redirect_to admin_announcements_path, notice: 'Announcement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to admin_announcements_path }
      format.json { head :no_content }
    end
  end

  #multiReorder 
	  def multiple_reorder
	  	errorFlag = false
	  	params[:announcement][:reorderset].each_with_index do | announceid , index | 
	  		@announcement = Announcement.find(announceid)
	  		if !@announcement.nil?
	  			@announcement.update_attribute(:ranking , index+1 )
	  		else
	  			errorFlag = true
	  		end	
	  	end
	  	
	  	respond_to do |format|
		  	 if errorFlag
		  	 	format.json { head :no_content }
		  	 else
		  	 	format.json { head :no_content }
		  	 end
		  end
		  
	  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
      params.require(:announcement).permit(:title, :article_id)
    end
end
