# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


def month_name(date)
  full_month_name_format = '%B'
  date.strftime(full_month_name_format)
end

def generate_random_number
  rand(-500..500)
end

def generate_description(value)
  case
    when value > 0
      "Rent payment"
    else
      "Rent to be paid"
  end
end

3.times do
  Contract.create!(name: "Flat in #{Faker::Address.city}", user: Faker::Name.name)
end

20.times do
  random_contract = Contract.all.sample
  random_date = Faker::Date.between(1.years.ago, Date.today)
  random_value = generate_random_number
  random_description = generate_description(random_value)

  Payment.create!(contract: random_contract,
                  description: random_description,
                  value: random_value,
                  time: random_date,
                  is_imported: false,
                  is_deleted: false)
end