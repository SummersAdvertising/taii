#encoding: utf-8
class Admin::BannersController < AdminController
  before_action :set_banner, only: [:show, :edit, :update, :destroy]

  # GET /banners
  # GET /banners.json
  def index
    @banners = Banner.with_translations(I18n.locale)
  end

  # GET /banners/1
  # GET /banners/1.json
  def show
  end

  # GET /banners/new
  def new
    @banner = Banner.create()
    
    respond_to do |format|
      if @banner.save
        format.html { redirect_to edit_admin_banner_path(@banner, locale: I18n.locale), notice: 'Banner was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @banner }
      else
        format.html { redirect_to admin_banners_path(locale: I18n.locale), notice: @banner.errors.full_messages }
        # format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /banners/1/edit
  def edit
    
    # @first_banner_of_this_locale = Banner.with_translations(I18n.locale).first

    # if @first_banner_of_this_locale.attachments.first
    #   @is_first_banner = @first_banner_of_this_locale.attachments.first.attachable_id == @banner.id ? true : false
    # else
    #   @is_first_banner = true
    # end
    
    # @banners = Banner.with_translations(I18n.locale)
    # @banners_attachment_count = 0

    # @banners.each do |banner|  
    #   @banners_attachment_count += 1 if banner.attachments.first
    # end

    @gallery_count = @banner.attachments.count
  end

  # POST /banners
  # POST /banners.json
  # def create
  #   @banner = Banner.create()
  #   # @banner.article = Article.new
  #   # @banner.title = "最新消息標題#{Time.now.strftime("%Y-%m-%d-%I")}"
    
  #   respond_to do |format|
  #     if @banner.save
  #       format.html { redirect_to edit_admin_banner_path(@banner, locale: I18n.locale), notice: 'Banner was successfully created.' }
  #       # format.json { render action: 'show', status: :created, location: @banner }
  #     else
  #       format.html { render action: 'new', notice: @banner.errors.full_messages }
  #       # format.json { render json: @banner.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /banners/1
  # PATCH/PUT /banners/1.json
  def update
    respond_to do |format|
      if @banner.update(banner_params)
        
        if params[:filename].present? 
          display_name = params[:filename] 
        else 
          display_name = "indexbanner-#{@banner.attachments.count + 1}"
        end
        
        Attachment.create(:attachment => params[:attachment], :attachable => @banner, :file_name => display_name) if params[:attachment]  

        format.html { redirect_to admin_banners_path(locale: I18n.locale), notice: 'Banner was successfully updated.' }
        format.json { head :no_content }
      else
        @gallery_count = @banner.attachments.count
        format.html { render action: 'edit' }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banners/1
  # DELETE /banners/1.json
  def destroy
    @banner.destroy
    respond_to do |format|
      format.html { redirect_to admin_banners_path(locale: I18n.locale) }
      format.json { head :no_content }
    end
  end

  #multiReorder 
  def multiple_reorder
    errorFlag = false
    params[:banner][:reorderset].each_with_index do | bannerid , index | 
      @banner = Banner.find(bannerid)
      if !@banner.nil?
        @banner.update_attribute(:ranking , index+1 )
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
    def set_banner
      @banner = Banner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def banner_params
      params.require(:banner).permit(:url_1, :url_2, :url_3)
    end
end
