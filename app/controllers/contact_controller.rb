#encoding: utf-8
class ContactController < ApplicationController
	#與我聯絡
	def contactus
		@organizations = Organization.with_translations(I18n.locale)
	end
end