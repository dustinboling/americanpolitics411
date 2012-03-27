class LegislationController < ApplicationController
  
  require 'open-uri'
  
  layout 'admin'
  
  def index
    list
    render('list')
  end
  
  def new
    @legislation = Legislation.new
  end
  
  def show
    if params[:bill_number]
      @legislation = Legislation.find_by_bill_number(params[:bill_number])
    else
      @legislation = Legislation.find(params[:id])
    end 
  end
  
  def edit
    @legislation = Legislation.find(params[:id])
  end
  
  def make_list
        
    url = "http://thomas.loc.gov/home/gpoxmlc112/"
    html = Nokogiri::HTML(open("http://thomas.loc.gov/home/gpoxmlc112/"))
    links = html.css('a')
    
    # Destroy all current data from legislations table
    Legislation.delete_all
    
    # Iterate through each link and make sure it is a link to xml.
    # If it is, then:
    # 1. grab the bill uri and save it to :legislations => :bill_uri
    # 2. invoke a Nokogiri::XML parser for the current bill_uri
    # 3. grab title and legis_num from xml
    # 4. create/save all to database.
    @bills = links.map  { |bill| 
      if bill.attribute('href').text.match(/xml/)
        bill_uri = bill.attribute('href').text
        @doc = Nokogiri::XML(open("http://thomas.loc.gov/home/gpoxmlc112/#{bill_uri}"))
        @legis_num = @doc.xpath('//legis-num').inner_text
        @title = @doc.xpath('//official-title').inner_text
        create_legislation = Legislation.new(:bill_uri => bill_uri, :bill_number => @legis_num, :bill_title => @title)
        create_legislation.save
      end }
      
  end
  
  def list
    @legislations = Legislation.order('bill_number ASC')
  end
  
  def update
    @legislation = Legislation.find(params[:id])
    
    respond_to do |format|
      if @legislation.update_attributes(params[:legislation])
        format.html { 
          flash[:notice] = 'Legislation has been successfully updated.'
          render 'edit'  }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @legislation.errors, status: :unprocessable_entity }
      end
    end
  end

end
