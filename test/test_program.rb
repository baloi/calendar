require './test/test_helper'

class ProgramTest < Test::Unit::TestCase
  def setup
  end

  def teardown
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
