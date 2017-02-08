
require 'csv'
require 'faker'

class Person

  attr_reader :first_name, :last_name, :email, :phone, :created_at

  def initialize(first_name, last_name, email, phone, created_at)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone = phone
    @created_at = created_at
  end
 
end

class PersonWriter
  
  def initialize(archivo, objetos)
    @archivo = archivo
    @objetos = objetos
  end

  def create_csv
    CSV.open(@archivo,'wb') do |csv|
      @objetos.each do |person| 
        csv << [person.first_name, person.last_name, person.email, person.phone, person.created_at] 
      end
    end
  end

end

class PersonParser

  def initialize(file)
    @file = file
  end

  def people
    array_new= []
    CSV.foreach(@file) do |row|
      persona = Person.new(row[0],row[1],row[2],row[3],row[4])
      array_new << persona
    end
    p array_new
  end


end

def person(number)
  array_people = []
  number.times do 
    array_people << Person.new(Faker::Name.first_name, Faker::Name.last_name, Faker::Internet.email, Faker::PhoneNumber.phone_number, Faker::Time.between(DateTime.now - 1, DateTime.now))
  end
  p array_people
end


people = person(10)

person_writer = PersonWriter.new("people.csv", people)
person_writer.create_csv

parser = PersonParser.new('people.csv')
people = parser.people





