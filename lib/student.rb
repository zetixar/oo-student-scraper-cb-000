class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |x|
      # binding.pry
      self.send("#{x[0].to_s}=", x[1])
      @@all << self
    end
  end

  def self.create_from_collection(students_array)
    students = []
    students_array.each do |student|
      @@all << Student.new(student)
    end
    self.all
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |x|
      self.send("#{x[0].to_s}=", x[1])
    end
    self
  end

  def self.all
    @@all
  end
end
