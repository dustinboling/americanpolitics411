class IssuesController < ApplicationController

  layout 'public'

  def index
    @issues = Issue.order('id ASC')
  end

  def show
    @issue = Issue.find(params[:id])
    @legislative_issue = Issue.where("name like ?", "#{@issue.name}").first.id
    @bills = LegislationIssue.where("issue_id = #{@legislative_issue}")
  end

  def edit
    @issue = Issue.find(params[:id])
  end

  def update
    @issue = Issue.find(params[:id])

    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        format.html {
          flash[:notice] = "#{@issue.name} has been successfully updated."
          redirect_to(:action => 'index')
        }
      else
        format.html { render action: 'edit' }
      end 
    end
  end
end
