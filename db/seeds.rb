# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
first_user = User.create(name: 'Bashful',
                         photo: 'https://drive.google.com/file/d/1XqjQFulatEIBwPbk_dQQ5HsdRapxHxDl/view?usp=sharing', bio: 'Hi there.', email: 'shy@snowdwarfs.com', password: '@Password=1')
second_user = User.create(name: 'Dopey',
                          photo: 'https://drive.google.com/file/d/1Wp1PnflGpKmeZBD0tBcq-yYMlEx_o_Fp/view?usp=sharing', bio: '........', email: 'dopey@snowdwarfs.com', password: '@Password=1')
third_user = User.create(name: 'Doc',
                         photo: 'hhttps://drive.google.com/file/d/1p0ATUoce5hwceUxYNboDApESI36QkUUK/view?usp=sharing', bio: 'An apple a day keeps this dwarf away.', email: 'doc@snowdwarfs.com', password: '@Password=1')

first_post = Post.create(author: first_user, title: 'Hello from Bashful 1', text: 'This is my first post')
second_post = Post.create(author: first_user, title: 'Hello from Bashful 2', text: 'This is my second post')
third_post = Post.create(author: first_user, title: 'Hello from Bashful 3', text: 'This is my third post')
fourth_post = Post.create(author: first_user, title: 'Hello from Bashful 4', text: 'This is my fourth post')

Comment.create(post: first_post, user: second_user, text: 'Hi!')
Comment.create(post: first_post, user: third_user, text: 'Aloha!')
Comment.create(post: first_post, user: first_user, text: 'Thanks!')
Comment.create(post: first_post, user: second_user, text: 'Ohayo!')
Comment.create(post: first_post, user: third_user, text: 'Hola!')
Comment.create(post: first_post, user: first_user, text: 'Hello!')
