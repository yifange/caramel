class InstrumentsController < ApplicationController
	def index
		verify_user
	end
end
