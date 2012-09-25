class Api::AutocompleteController < ApplicationController

  ###
  # PEOPLE
  #
  def autocomplete_person_name
    @people = Person.order(:name).where("name ilike ?", "%#{params[:term]}%")
    render json: @people.map(&:name)
  end

  def autocomplete_person_name_to_slug
    @people = Person.order(:slug).where("slug ilike ?", "%#{params[:term]}%")
    render json: @people.collect { |p| 
      { 
        :label => "#{p.first_name} #{p.last_name}", 
        :value => p.slug 
      } 
    }
  end

  ###
  # RELIGIONS
  #
  def autocomplete_religion_name
    @religions = Religion.order(:name).where("name ilike ?", "%#{params[:term]}%")
    render json: @religions.map(&:name)
  end

  ###
  # UNIVERSITIES
  #
  def autocomplete_university_name
    @universities = University.order(:name).where("name ilike ?", "%#{params[:term]}%")
    render json: @universities.map(&:name)
  end

  ###
  # ORGANIZATIONS
  #
  def autocomplete_organization_name
    @organizations = Organization.order(:name).where("name ilike ?", "%#{params[:term]}%")
    render json: @organizations.map(&:name)
  end
  
  ###
  # ISSUES
  #
  def autocomplete_main_issues_name
    @main_issues = MainIssue.order(:name).where("name ilike?", "%#{params[:term]}%")
    render json: @main_issues.map(&:name)  
  end

  def autocomplete_issues_name
    @issues = Issue.order(:name).where("name ilike?", "%#{params[:term]}%")
    render json: @issues.map(&:name) 
  end

  def autocomplete_issues_name_id
    @issues = Issue.order(:name).where("name ilike?", "%#{params[:term]}%")
    render json: @issues.collect { |i|
      {
        :label => "#{i.name}",
        :value => i.id
      }
    }
  end

end
