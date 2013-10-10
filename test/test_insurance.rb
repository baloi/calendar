require './test/test_helper'

class InsuranceTest < Test::Unit::TestCase
  def setup
    clear_database
  end

  def teardown 
    clear_database
  end
  
  def test_constants
    assert Insurance::MEDA == "Med A"
    assert Insurance::MEDB == "Med B"
    assert Insurance::CDPHP == "Commercial, CDPHP"
  end

  def test_is_commercial
    assert Insurance.is_commercial(Insurance::CDPHP) == true
    assert Insurance.is_commercial(Insurance::MEDA) == false
    assert Insurance.is_commercial(Insurance::MEDB) == false
  end
end
