

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(email: "abc@gmail.com", password: "12345678", password_confirmation: "12345678")


artist = Artist.create(name: 'The Breeders')

album = Album.create(artist_id: artist.id, user_id: user.id, title: 'Last Splash', 
	year: 1994, album_art: "http://upload.wikimedia.org/wikipedia/en/thumb/f/f3/TheBreedersLastSplash.jpg/220px-TheBreedersLastSplash.jpg",
	body: "Bacon ipsum dolor sit amet biltong kielbasa ribeye andouille, leberkas short ribs turkey porchetta capicola. Spare ribs meatball 
	strip steak landjaeger turkey porchetta venison frankfurter bresaola. Andouille pig kevin pastrami tail, strip steak brisket turkey. Sirloin 
	drumstick pig rump chuck, short ribs ham t-bone strip steak. Cow venison rump, pork belly jowl ribeye kielbasa andouille turducken tri-tip 
	turkey doner kevin leberkas. Frankfurter capicola turkey meatball ground round sirloin. Tenderloin pancetta brisket tri-tip.",
	spotify_identifier: "4lxW0axOKlImAQ0akMRz61")