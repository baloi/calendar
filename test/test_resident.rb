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

  def test_all_on_insurance
    karpov = Resident.new
    karpov.lastname = "Karpov"
    karpov.insurance = Insurance::MEDB
    karpov.save

    kasparov = Resident.new
    kasparov.lastname = "Kasparov"
    kasparov.insurance = Insurance::MEDA
    kasparov.save

    has_med_b = Resident.all_insured_by(Insurance::MEDB)

    assert has_med_b.count == 1
    assert_equal has_med_b.first.lastname, 'Karpov'

    has_med_a = Resident.all_insured_by(Insurance::MEDA)

    assert has_med_a.count == 1
    assert has_med_a.first.lastname == "Kasparov"
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
