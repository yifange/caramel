class ProgramController < ApplicationController
  def index
    @programs = Program.all
  end
end
