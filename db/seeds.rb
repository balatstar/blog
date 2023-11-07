# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
first_user = User.create(name: 'Sneezy',
                         photo: 'https://drive.google.com/file/d/1XqjQFulatEIBwPbk_dQQ5HsdRapxHxDl/view?usp=sharing', bio: 'Achooo!')
second_user = User.create(name: 'Grumpy',
                          photo: 'https://drive.google.com/file/d/1Wp1PnflGpKmeZBD0tBcq-yYMlEx_o_Fp/view?usp=sharing', bio: 'Grr. Argh.')
third_user = User.create(name: 'Doc',
                         photo: 'hhttps://drive.google.com/file/d/1p0ATUoce5hwceUxYNboDApESI36QkUUK/view?usp=sharing', bio: 'An apple a day keeps this dwarf away.')

first_post = Post.create(author: first_user, title: 'Hello from Sneezy 1', text: 'This is my first post')
second_post = Post.create(author: first_user, title: 'Hello from Sneezy 2', text: 'This is my second post')
third_post = Post.create(author: first_user, title: 'Hello from Sneezy 3', text: 'This is my third post')
fourth_post = Post.create(author: first_user, title: 'Hello from Sneezy 4', text: 'This is my fourth post')

Comment.create(post: first_post, user: second_user, text: 'Hey Sneezy! Get off my lawn.')
Comment.create(post: first_post, user: third_user, text: 'Gesundheit!')
Comment.create(post: first_post, user: first_user, text: 'Thanks!')
Comment.create(post: first_post, user: second_user, text: 'Nope...')
Comment.create(post: first_post, user: third_user, text: 'Hello Sneezy!')
Comment.create(post: first_post, user: first_user, text: 'Hello!')
