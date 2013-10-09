require './test/test_helper'

class ResidentTest < Test::Unit::TestCase
  def setup
    clear_database
  end

  def teardown 
    clear_database
  end

  def test_show_all
    #assert Resident.show_all == ''
  end

  def test_it_works
    assert true
  end

  def test_primary_pt
    lastname = "Alekhine"
    firstname = "Alexander"
    
    therapist_lastname = "Galilili"
    therapist_firstname = "Doda"

    resident = Resident.new
    resident.lastname = lastname 
    resident.firstname = firstname 

    therapist = Therapist.new
    therapist.discipline = "PT"
    therapist.firstname = therapist_firstname
    therapist.lastname = therapist_lastname
    therapist.save

    resident.primary_pt = therapist
    resident.save

    t = Therapist.all.first
    assert t.firstname == therapist_firstname
    assert resident.primary_pt.lastname == therapist_lastname

  end

  def test_add_resident
    lastname = "Alekhine"
    firstname = "Alexander"
    
    therapist_lastname = "Galilili"
    therapist_firstname = "Doda"

    resident = Resident.new
    resident.lastname = lastname 
    resident.firstname = firstname 
    resident.save

    r = Resident.all.first
    assert_equal(r.firstname, firstname)
    assert_equal(r.lastname, lastname)
  end
end
