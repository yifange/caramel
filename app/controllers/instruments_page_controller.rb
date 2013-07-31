class InstrumentsPageController < ApplicationController
	def index
		verify_user
	end
end
