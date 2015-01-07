#encoding: utf-8
class SearchController < ApplicationController

	def index
	  @hq_root_node = Hqlevel.return_root_node_on_demand("#{I18n.locale}")
	  @br_root_node = Brlevel.return_root_node_on_demand("#{I18n.locale}")
		
    words = params[:q].delete(:translations_name_cont)
    # p words
    if words.present?
      params[:q][:groupings] = []
      words.split(/[ 　]/).each_with_index do |word, i| #全角空白と半角空白で切って、単語ごとに処理します
        params[:q][:groupings][i] = { translations_name_cont: word }
      end
    end

    @q = Hqproduct.with_translations(I18n.locale).where(showatfront: 200).search(params[:q].try(:merge, m: 'or'))
    @hq_result = @q.result(distinct: true)
    @hq_has_results = !@hq_result.nil? && @hq_result.count > 0 ? true : false

    @q = Brproduct.with_translations(I18n.locale).where(showatfront: 200).search(params[:q].try(:merge, m: 'or'))
    @br_result = @q.result(distinct: true)
    @br_has_results = !@br_result.nil? && @br_result.count > 0 ? true : false


    #unless params[:search].blank?
      # @hq_result = Hqproduct.search(params[:search])
  		# @br_result = Brproduct.search(params[:search])
    #end

    #@hq_result = nil
    #@hq_result = nil

	end
	
end