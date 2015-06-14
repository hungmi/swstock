# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Item.destroy_all
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'items'")

@customer_names =  ['富暘', '油機', '東台', '金玉']

for k in 1..2 do
  for i in 1..4 do
    Item.create!([location: "A#{k}-#{i}", picnum: "拉桿95長1234#{k}#{i}5678+活塞45長12399#{k}#{i}7533", finished: "#{i}", unfinished: "abc#{k}", customer:@customer_names[i - 1]])
  end
end

for k in 1..2 do
  for i in 1..4 do
    Item.create!([location: "B#{k}-#{i}", picnum: "12345678#{k}#{i}", finished: "#{i}", unfinished: "abc#{k}"])
  end
end

puts "Initialization Finish."