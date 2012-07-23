class Api::AutocompleteController < ApplicationController

  ###
  # PEOPLE
  #
  def autocomplete_person_name
    @people = Person.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @people.map(&:name)
  end

  def autocomplete_person_url
    @people = Person.order(:slug).where("slug like ?", "%#{params[:term]}%")
    render json: @people.collect { |p| { :label => "#{p.first_name} #{p.last_name}", :value => p.slug } }
  end

  ###
  # RELIGIONS
  #
  def autocomplete_religion_name
    @religions = Religion.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @religions.map { |r|
      { :label => "#{r.name}",
        :value => p.id 
      }
    }
  end


end
