class VisitorsController < ApplicationController
  def index

  end

  def search
    search = Search.new params[:query]
    search.process
    @results = search.results
    render action: :index
  end
end
