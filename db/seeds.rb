# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
#
# restaurants_list = [
#   ["Green Nature Coffee House", "555 W 42nd St (11th Avenue) New York, NY 10036, United States", "526d9114498ec8efda93fcce"],
#   ["Caffe Romeo", "7111 20th Ave, Brooklyn, NY 11204, United States", "4bf58dd8d48988d1e0931735"],
#   ["Romeo's Ristorante", "120 E 15th St, New York, NY 10003, United States", "4f442c0b19836ed00192aed8"],
#   ["Romeo Brothers Meats and Foods", "7801 15th Ave, Brooklyn, NY 11228, United States", "4f32902519836c91c7e40114"]
# ]
#
# reviews_list = [
#   ["one review", 10, 10, 10, 1, 1],
#   ["caffe romeo review", 10, 10, 10, 1, 1],
#   ["romeo's ristorante review", 10, 8, 8, 2, 2],
#   ["Romeo Brothers Meats and Foods review content", 5, 3, 1, 2, 2]
# ]
#
# users_list = [
#   ["John Doe", "12345", "john.doe@gmail.com"],
#   ["Jane Doe", "69420", "jane.doe@gmail.com"]
# ]
#
# searches_list = [
#   ["slgkjdflkgjdflgkdj", "Speedy Romano", "10038"]
#   # ["", "", ""],
#   # [],
#   # [],
#
# ]
#
# restaurants_list.each do |name, address, foursquare_id|
#   Restaurant.create(name: name, address: address, foursquare_id: foursquare_id)
# end
#
# reviews_list.each do |content, food_rating, environment_rating,service_rating, restaurant_id, user_id|
#   Review.create(content: content, food_rating: food_rating, environment_rating: environment_rating, service_rating: service_rating, restaurant_id: restaurant_id, user_id: user_id)
# end
#
# users_list.each do |name, password, email|
#   User.create(name: name, password: password, email: email)
# end
#
# searches_list.each do |query, search, location|
#   Search.create(query: query, search: search, location: location)
# end
