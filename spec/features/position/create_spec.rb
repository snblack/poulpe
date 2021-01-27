require "rails_helper"

feature 'User can see last position' do
  given!(:keyword) {create(:keyword)}

  scenario 'user see last position' do
    visit products_path
    click_on 'Update positions'

    sleep 3

    expect(page).to have_content keyword.positions.last.value
    expect(page).to have_content 'Positions ware updated'

    save_and_open_page
  end
end
