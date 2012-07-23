class MainIssuesController < ApplicationController
  layout 'admin'

  def index
    @main_issues = MainIssue.order('name ASC')
  end

  def show
    @main_issue = MainIssue.find(params[:id]) 
  end

  def edit
    @main_issue = MainIssue.find(params[:id])
  end

  def new
    @main_issue = MainIssue.new 

    respond_to do |format|
      format.html
    end
  end

  def create
    @main_issue = MainIssue.new(params[:main_issue])

    if @main_issue.save
      respond_to do |format|
        format.html {
          flash[:notice] = 'Main Issue added successfully.'
          redirect_to(:action => 'index')
        }
      end
    end
  end

  def update
    @main_issue = MainIssue.find(params[:id]) 

    respond_to do |format|
      if @main_issue.update_attributes(params[:main_issue])
        format.html {
          flash[:notice] = "#{@main_issue.name} has been successfully updated."
          redirect_to(:action => 'index')
        }
      else
        format.html { render action: "edit" }
        format.json { render json: @main_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @main_issue = MainIssue.find(params[:id])
    @main_issue.destroy

    respond_to do |format|
      format.html { redirect_to main_issues_url }
    end
  end

end
