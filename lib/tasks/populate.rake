namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    [Product].each(&:delete_all)

    Product.populate 100 do |product|
      product.name = Populator.words(1..3).titleize
      product.owner = Faker::Name.name
      product.quantity = 1..30
    end
  end
end
