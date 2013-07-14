require 'sinatra'
require 'sequel'
require './model'

# the methods will be available in all routes and views
helpers do
  def delete_resident_button(resident_id)
    # renders a partial template at views/_delete_resident_button.erb
    erb :"resident/_delete_resident_button", 
        locals: { resident_id: resident_id }
  end

  def delete_therapist_button(therapist_id)
    # renders a partial template at views/_delete_therapist_button.erb
    erb :"therapist/_delete_therapist_button", 
        locals: { therapist_id: therapist_id }
  end

end

get "/" do
  "My Calendar"
end

get "/create_database" do
  create_database
  'Database created....'
end

get "/calendar/month" do
  @days = [2, 3, 4]
  erb :"/calendar/month"
end

#-- Resident methods --#

get "/resident/new" do
  @title = "New Resident"
  @resident = Resident.new
  erb :"resident/new" 
end

get "/resident/list" do
  #  @residents = Resident.all
  erb :"/resident/list"
end

post "/resident" do
  #@resident = Resident.new(params[:resident])
  lastname = params[:resident][:lastname]
  firstname = params[:resident][:firstname]
  insurance = params[:resident][:insurance]
  admit_date = params[:resident][:admit_date].to_s
  admit_date = Date.new(admit_date[0,4].to_i, 
                    admit_date[4,2].to_i, 
                    admit_date[6,2].to_i)

  @resident = Resident.new

  #"#{admit_date[6,2]}<br/>"
  @resident.firstname = firstname
  @resident.lastname = lastname
  @resident.insurance = insurance
  @resident.admit_date = admit_date
  
  if @resident.save
    redirect "/resident/#{@resident.id}"
  else
    erb :"/resident/new"
  end
end

delete "/resident/:id" do
  Resident.find(params[:id]).delete
  redirect "/resident/list"
end

# this method should be after any method with url: "/resident/*"
# as the ":id" part would clash with any other appendage of /resident
get "/resident/:id" do
  id = params[:id]
  @resident = Resident[id]
  erb :"/resident/show" 
end

#-- Therapist methods --#

get "/therapist/new" do
  @title = "New Resident"
  @therapist = Therapist.new
  erb :"therapist/new" 
end

get "/therapist/list" do
  #  @therapists = Therapist.all
  erb :"/therapist/list"
end

post "/therapist" do
  #@therapist = Therapist.new(params[:therapist])
  lastname = params[:therapist][:lastname]
  firstname = params[:therapist][:firstname]
  discipline = params[:therapist][:discipline]

  @therapist = Therapist.new

  #"#{admit_date[6,2]}<br/>"
  @therapist.firstname = firstname
  @therapist.lastname = lastname
  @therapist.discipline = discipline
  
  if @therapist.save
    redirect "/therapist/#{@therapist.id}"
  else
    erb :"/therapist/new"
  end
end

delete "/therapist/:id" do
  Therapist.find(params[:id]).delete
  redirect "/therapist/list"
end

# this method should be after any method with url: "/therapist/*"
# as the ":id" part would clash with any other appendage of /therapist
get "/therapist/:id" do
  id = params[:id]
  @therapist = Therapist[id]
  erb :"/therapist/show" 
end
