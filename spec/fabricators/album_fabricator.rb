Fabricator(:album) do

	artist
	title { Faker::Lorem.words }
	album_art { Faker::Avatar.image }
	user
	year { Faker::Number.number(4)}
	body { Faker::Lorem.paragraphs }
	workflow_state "accepted"
	published true
end