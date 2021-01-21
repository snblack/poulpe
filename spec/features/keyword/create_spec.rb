require "rails_helper"

feature 'User can create keywords' do
  given!(:product) {create(:product)}

  background do
    visit products_path
    click_on 'Add keywords'
  end

  scenario 'user create one keyword with valid attributes' do
    fill_in 'List keywords', with: "magsafe 1"

    click_on 'Create keyword'

    expect(page).to have_content 'Keywords for product succesfully added'
    expect(page).to have_content 'magsafe 1'
  end

  scenario 'user create any keyword with valid attributes' do
    fill_in 'List keywords', with: "magsafe 1
      magsafe 2"

    click_on 'Create keyword'

    expect(page).to have_content 'Keywords for product succesfully added'
    expect(page).to have_content 'magsafe 1'
    expect(page).to have_content 'magsafe 2'
  end

  scenario 'user create keywords with empty attributes' do
    fill_in 'List keywords', with: ""

    click_on 'Create keyword'

    expect(page).to have_content 'Please, add one and any phrases'
  end

  scenario 'user create product without words' do
    fill_in 'List keywords', with: "==-=-"

    click_on 'Create keyword'

    expect(page).to have_content 'Wrong format ASIN'
    expect(page).to_not have_content '==-=-'
  end

end
