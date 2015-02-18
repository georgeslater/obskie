require 'rails_helper'

feature 'User accesses main page' do

	scenario 'they load the page for the first time' do
		visit root_path

		num_albums = Album.where("workflow_state = 'accepted'").count

		expect(page).to have_selector('figure', count: num_albums)
	end

	scenario 'User changes the sort order', :js => true do

		album1 = Fabricate(:album)
		album2 = Fabricate(:album)

		sleep(5)

		visit root_path

		expect(page).to have_content(album1.title)
		expect(page).to have_content(album2.title)		
		
		expect(album2.title).to appear_before(album1.title)

		page.execute_script("changeSortOrderJs('Oldest first')") 

		expect(album1.title).to appear_before(album2.title)		
	end
end