DB = Sequel.connect('sqlite://calendar.db')

def create_database
  DB.create_table :days do
    primary_key :id
    Date :date    
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

  def primary_pt=(pt)
    self.primary_pt_id = pt.id
  end
end

class Therapist < Sequel::Model
  #many_to_many :residents
end

class Calendar

end
