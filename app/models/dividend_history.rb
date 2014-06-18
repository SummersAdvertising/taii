class DividendHistory < ActiveRecord::Base
	default_scope { order('ranking, created_at') }
	
end
