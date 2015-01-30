require 'rails_helper'

feature 'User accesses main page' do

	Fabricate(:album)
	scenario 'they load the page for the first time' do
		visit root_path

		num_albums = Album.where("workflow_state = 'accepted'").count

		expect(page).to have_selector('figure', count: num_albums)
	end

	scenario 'User changes the sort order', :js => true do

		visit root_path

		find('#sort_by').find(:xpath, 'option[1]').select_option

		oldest_album = Album.order('created_at ASC').limit(1)

		expect('.albumCaptureTitle'[0]).to eq(oldest_album.year)
	end
end