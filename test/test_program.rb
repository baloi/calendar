require './test/test_helper'

class ProgramTest < Test::Unit::TestCase
  def setup
    clear_database
  end

  def teardown
    clear_database
  end

  def test_initialize_open
    program = Program.new
    program.open = true
    program.save
    p = Program.all.first
    assert p.open == true
  end

  def test_number_of_weeks
    program = Program.new
    program.start_date = Date.new(2013, 10, 1)
    program.open = true
    program.save

    p = Program.all.first
    assert p.open == true
    assert p.start_date.year == 2013
    assert p.start_date.mon ==  10 
    assert p.start_date.mday == 1
  end

  def test_new
    program = Program.new
    program.start_date = Date.new(2004, 6, 10)
    program.open = true 
    program.save

    p = Program.all.first
    assert p.open == true
    assert p.start_date.year == 2004
    assert p.start_date.mon == 6
    assert p.start_date.mday == 10 
  end
end
