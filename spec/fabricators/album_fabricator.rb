Fabricator(:album) do

	artist
	title { Faker::Lorem.words }
	user
end