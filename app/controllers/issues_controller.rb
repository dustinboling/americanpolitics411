class IssuesController < ApplicationController
  
  layout 'admin'
  
  def index
    @issues = Issue.order('id ASC')
  end

  def show
    @issue = Issue.find_by_id(params[:id])
    @legislative_issue = Issue.where("name like ?", "#{@issue.name}").first.id
    @bills = LegislationIssue.where("issue_id = #{@legislative_issue}")
  end

end