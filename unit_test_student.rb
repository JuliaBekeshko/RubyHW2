require 'minitest/autorun'
require 'minitest/reporters'
require 'date'
require_relative 'rubyHW1'

# Using Minitest reporters to generate an HTML report
Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new

class StudentTest < Minitest::Test
  def setup
    Student.class_variable_set(:@@students, []) # Reset the students array before each test
    @student1 = Student.new("Bekeshko", "Julia", Date.new(2005, 2, 19))
    @student2 = Student.new("Prysiazhniuk", "Sofia", Date.new(2006, 3, 2))
  end

  def test_initialize
    assert_equal "Julia", @student1.name
    assert_equal "Bekeshko", @student1.surname
    assert_equal Date.new(2005, 2, 19), @student1.date_of_birth
  end

  def test_calculate_age
    assert_equal Date.today.year - 2005, @student1.calculate_age
    assert_equal Date.today.year - 2006, @student2.calculate_age
  end

  def test_unique_students
    duplicate_student = Student.new("Bekeshko", "Julia", Date.new(2005, 2, 19))
    assert_equal 2, Student.students.size
  end

  def test_get_students_by_age
    age = Date.today.year - 2005
    assert_includes Student.get_students_by_age(age), @student1
  end

  def test_get_students_by_name
    assert_includes Student.get_students_by_name("Julia"), @student1
  end

  def test_eql_method
    other = Student.new("Bekeshko", "Julia", Date.new(2005, 2, 19))
    assert @student1.eql?(other)
  end

  def test_invalid_date_of_birth
    assert_raises(ArgumentError) { Student.new("Smith", "John", Date.today + 1) }
  end
end
