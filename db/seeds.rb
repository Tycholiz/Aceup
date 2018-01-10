# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Faker::Config.locale = "en-CA"

User.destroy_all

password = "testtest"

User.create! [
	email: "employer@test.com",
	# password_digest: User.new(:password => password).password_digest,
	password: password,
	password_confirmation: password,
	firstName: "Employer",
	lastName:  "Name",
	phoneNo:  Faker::PhoneNumber.cell_phone,
	role:  "Employer"
]

User.create! [
	email: "employer2@test.com",
	# password_digest: User.new(:password => password).password_digest,
	password: password,
	password_confirmation: password,
	firstName: "Employer2",
	lastName:  "Name2",
	phoneNo:  Faker::PhoneNumber.cell_phone,
	role:  "Employer"
]

User.create! [
	email: "super@test.com",
	password: password,
	password_confirmation: password,
	firstName: "Super",
	lastName:  "Seeker",
	phoneNo:  Faker::PhoneNumber.cell_phone,
	role:  "Seeker"
]

User.create! [
	email: "normal@test.com",
	password: password,
	password_confirmation: password,
	firstName: "Normal",
	lastName:  "Seeker",
	phoneNo:  Faker::PhoneNumber.cell_phone,
	role:  "Seeker"
]


p "Created #{User.count} users"

# Employer.destroy_all

Employer.create! [
	user_id: 1,
	compName: Faker::Company.name,
	compSize: Faker::Number.between(1, 1000),
	city: Faker::Address.city,
	compDesc: Faker::RickAndMorty.quote,
]

Employer.create! [
	user_id: 2,
	compName: Faker::Company.name,
	compSize: Faker::Number.between(1, 1000),
	city: Faker::Address.city,
	compDesc: Faker::RickAndMorty.quote,
]

p "Created #{Employer.count} employers"

# Seeker.destroy_all

Seeker.create! [
	user_id: 3,
	postalCode: Faker::Address.postcode,
	educationLevel: Faker::Beer.style,
	degree: Faker::Beer.style,
	inSales: 10,
	outSales: 10,
	inboundSales: true,
	outboundSales: true,
	coldCall: true,
	doorToDoor: true,
	custService: true,
	acctManagment: true,
	negotiation: true,
	presenting: true,
	leadership: true,
	closing: true,
	hunterBased: true,
	farmerBased: true,
	commBased: true,
	B2C: true,
	B2B: true,
	consSales: true,
	directSales: true,
	solutionSales: true,
	languages: ['English', 'French', 'Mandarin'],
	certifications: ['VSA', 'CFA (level 1)', 'CFA (level 2)', 'CFA (level 3)', 'CSC', 'CIP', 'LLQP', 'CAIB', 'Insurance Broker (level 1)', 'Insurance Broker (level 2)', 'Insurance Broker (level 3)']
]

Seeker.create! [
	user_id: 4,
	postalCode: Faker::Address.postcode,
	educationLevel: Faker::Beer.style,
	degree: Faker::Beer.style,
	inSales: Faker::Number.between(1, 5),
	outSales: Faker::Number.between(1, 5),
	inboundSales: Faker::Boolean.boolean,
	outboundSales: Faker::Boolean.boolean,
	coldCall: Faker::Boolean.boolean,
	doorToDoor: Faker::Boolean.boolean,
	custService: Faker::Boolean.boolean,
	acctManagment: Faker::Boolean.boolean,
	negotiation: Faker::Boolean.boolean,
	presenting: Faker::Boolean.boolean,
	leadership: Faker::Boolean.boolean,
	closing: Faker::Boolean.boolean,
	hunterBased: Faker::Boolean.boolean,
	farmerBased: Faker::Boolean.boolean,
	commBased: Faker::Boolean.boolean,
	B2C: Faker::Boolean.boolean,
	B2B: Faker::Boolean.boolean,
	consSales: Faker::Boolean.boolean,
	directSales: Faker::Boolean.boolean,
	solutionSales: Faker::Boolean.boolean,
	languages: ['English', 'French'],
	certifications: ['VSA', 'CFA (level 1)', 'CFA (level 2)', 'CFA (level 3)', 'CSC', 'CIP', 'LLQP', 'CAIB', 'Insurance Broker (level 1)', 'Insurance Broker (level 2)', 'Insurance Broker (level 3)']
]
p "Created #{Seeker.count} seekers"

Job.destroy_all

100.times do
	Job.create! [
		title: Faker::Job.title,
		employer_id: Faker::Number.between(3, 2),
		jobType: ['part-time', 'full-time'].sample,
		expiry: Time.now.advance(weeks: 2), 
		temp: true,
		salary: ['Salary', 'Hourly', 'Commission'].sample,
		payLow: Faker::Number.between(20000, 50000),
		payHigh: Faker::Number.between(50000, 100000),
		inSalesSoft: Faker::Number.between(1, 5),
		inSalesHard: Faker::Number.between(1, 5),
		outSalesSoft: Faker::Number.between(1, 5),
		outSalesHard: Faker::Number.between(1, 5),
		summary: Faker::RickAndMorty.quote,
		functions: Faker::RickAndMorty.quote,
		skills: Faker::Job.key_skill,
		competencies: Faker::RickAndMorty.quote,
		deptSize: Faker::Number.between(1, 1000),
		benefits: Faker::Seinfeld.quote,
		coldCall: Faker::Boolean.boolean,
		doorToDoor: Faker::Boolean.boolean,
		custService: Faker::Boolean.boolean,
		acctManagment: Faker::Boolean.boolean,
		negotiation: Faker::Boolean.boolean,
		presenting: Faker::Boolean.boolean,
		leadership: Faker::Boolean.boolean,
		closing: Faker::Boolean.boolean,
		hunterBased: Faker::Boolean.boolean,
		farmerBased: Faker::Boolean.boolean,
		commBased: Faker::Boolean.boolean,
		B2C: Faker::Boolean.boolean,
		B2B: Faker::Boolean.boolean,
		consSales: Faker::Boolean.boolean,
		directSales: Faker::Boolean.boolean,
		solutionSales: Faker::Boolean.boolean,
		languages: ['English', 'French'],
	]
	
end

p "Created #{Job.count} jobs"