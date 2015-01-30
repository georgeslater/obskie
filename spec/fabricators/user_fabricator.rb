Fabricator(:user) do
	
	email { Faker::Internet.email }
	username { Faker::Internet.user_name }
	password { '12345678' }
end