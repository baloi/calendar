require 'sequel'
#DB = nil 


if $TEST == true
  DB = Sequel.connect('sqlite://test.db')
else
  DB = Sequel.connect('sqlite://calendar.db')
end

def create_database
  DB.create_table :days do
    primary_key :id
    Date :date    
  end

  DB.create_table :programs do
    primary_key :id
    String :resident_id
    Date :start_date
    Date :end_date
    TrueClass :open
  end


  DB.create_table :residents do
    primary_key :id
    String :lastname
    String :firstname
    String :insurance
    Date :admit_date
    Integer :primary_ot_id
    Integer :primary_pt_id
  end

  DB.create_table :therapists do
    primary_key :id
    String :lastname
    String :firstname
    String :discipline
  end

  #DB.create_table :therapists_residents do
  #  primary_key :id
  #  foreign_key :therapist_id, :therapists
  #  foreign_key :resident_id, :residents
  #end

end

class Resident < Sequel::Model
  def primary_pt
    return Therapist[self.primary_pt_id]
  end

  def primary_ot
    return Therapist[self.primary_ot_id]
  end

  def primary_pt=(pt)
    self.primary_pt_id = pt.id
  end

  def primary_ot=(ot)
    self.primary_ot_id = ot.id
  end

  def self.show_all
    Resident.all do |r|
      puts r.firstname + ' ' + r.lastname + ', ' + r.insurance
    end
  end
end

class Therapist < Sequel::Model

  # returns an array of hashes, example:
  #   t = Therapist[1]
  #   residents = t.residents
  # Then to print the lastname(example) of the first resident:
  #   puts residents.first[:lastname] 
  def residents
    residents = nil
    all_residents = DB[:residents] # can also be DB.from(:residents)

    residents = all_residents.where(:primary_pt_id => self.id)

    # remember that we are returning an array of hashes
    return residents
  end

  # returns all OT's
  def self.all_ot
    Therapist.where(:discipline => "OT").all
  end

  def self.all_pt
    Therapist.where(:discipline => "PT").all
  end
end

class Program < Sequel::Model
  #def before_create
  # self.open ||= true
  # set (:open => true)
  # super
  #end
end

class Insurance
  MEDA = "Med A"
  MEDB = "Med B"
  CDPHP = "Commercial, CDPHP"

  def self.is_commercial(insurance_name)
    insurance_type = insurance_name.split(",")[0]
    return insurance_type == 'Commercial'
  end
end


class Calendar

end

# just to have a list of therapists
if $TEST != true # only if this is the live database
  require './therapist_list'
  include TherapistList 
end

def clear_database
  # delete * from programs
  DB[:programs].delete
  DB[:days].delete
  DB[:residents].delete
  DB[:therapists].delete
end
