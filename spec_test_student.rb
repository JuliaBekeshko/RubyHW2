require 'minitest/autorun'
require 'minitest/reporters'
require 'date'
require_relative 'rubyHW1'

# Using Minitest reporters to generate an HTML report
Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new

describe Student do
  before do
    Student.class_variable_set(:@@students, []) # Reset the students array before each test
    @student1 = Student.new("Bekeshko", "Julia", Date.new(2005, 2, 19))
    @student2 = Student.new("Prysiazhniuk", "Sofia", Date.new(2006, 3, 2))
  end

  it "initializes with the correct attributes" do
    _(@student1.name).must_equal "Julia"
    _(@student1.surname).must_equal "Bekeshko"
    _(@student1.date_of_birth).must_equal Date.new(2005, 2, 19)
  end

  it "calculates the correct age" do
    _(@student1.calculate_age).must_equal Date.today.year - 2005
    _(@student2.calculate_age).must_equal Date.today.year - 2006
  end

  it "ensures students are unique" do
    duplicate_student = Student.new("Bekeshko", "Julia", Date.new(2005, 2, 19))
    _(Student.students.size).must_equal 2
  end

  it "gets students by age" do
    age = Date.today.year - 2005
    _(Student.get_students_by_age(age)).must_include @student1
  end

  it "gets students by name" do
    _(Student.get_students_by_name("Julia")).must_include @student1
  end

  it "checks equality of students" do
    other = Student.new("Bekeshko", "Julia", Date.new(2005, 2, 19))
    _(@student1.eql?(other)).must_equal true
  end

  it "raises an error for future date of birth" do
    _(proc { Student.new("Smith", "John", Date.today + 1) }).must_raise ArgumentError
  end
end
