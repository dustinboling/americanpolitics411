class IssuesController < ApplicationController
  
  layout 'admin'
  
  def index
    @issues = Issue.order('id ASC')
  end

  def show
    @issue = Issue.find_by_id(params[:id])
  end

end