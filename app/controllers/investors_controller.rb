#encoding: utf-8
class InvestorsController < ApplicationController

  #保留管理 investor底下的靜態頁
	def show
	
	  if params[ :investor ].nil?
			redirect_to investors_path and return
		end
		
		respond_to do | format |
			format.html { render :template => 'investors/' + params[ :investor ]  rescue redirect_to '/errors' }
		end

	end
	
	def annualreport
		#只顯示當年度
		#max_year = Annualreport.maximum("fiscal_year")
    #max_year_id = Annualreport.where(["fiscal_year = ?", max_year]).select(:id)
    #@currentYear = Annualreport.find(max_year_id)
    #全列
    @allYear = Annualreport.all
	end
	
	def dividend_history
		@dividend_histories = DividendHistory.all
	end
	
	def financialreport
		@financialreports = Financialreport.all
	end
	
	def majorresolution
		#只顯示當年度
		#max_year = Majorresolution.maximum("fiscal_year")
    #max_year_id = Majorresolution.where(["fiscal_year = ?", max_year]).select(:id)
    #@currentYear = Majorresolution.find(max_year_id)
    #全列
    @allYear = Majorresolution.all
	end
	
	def financialprojection
	  @currentYear = Financialprojection.first
	end
	
	def monthlyrevenuereport
	  max_year = Monthlyrevenuereport.maximum("fiscal_year")
    max_year_id = Monthlyrevenuereport.where(["fiscal_year = ?", max_year]).select(:id)
    @active_monthly_report = Monthlyrevenuereport.find(max_year_id)	
     
		if !params[:fiscal_month].nil?
			@currentMonth = params[:fiscal_month]
			@revenue_items = @active_monthly_report.revenue_items.where('fiscal_month='+@currentMonth.to_s)
		end
  	
		#歷年營收資料
  	@history_array =  Historyrevenuereport.where("fiscal_year < ? ",@active_monthly_report.fiscal_year).order('fiscal_year desc').select(:id).limit(8).map {|i| i.id }
  	@historyRevenues = Attachment.where(attachable_id: @history_array, attachable_type: "Historyrevenuereport").index_by(&:attachable_id).slice(*@history_array).values

	end
	
	def majorpolicy
		@currentYear = Majorpolicy.first
	end
	
end