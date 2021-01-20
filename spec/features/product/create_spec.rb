require "rails_helper"

feature 'User can create product' do
  scenario 'user create product with valid attributes' do
    visit products_path
    click_on 'Add product'

    fill_in 'Asin', with: "B07PYLT6DN"

    click_on 'Add'

    expect(page).to have_content 'Your product succesfully added'
  end

  scenario 'user create product with empty attributes' do
    visit products_path
    click_on 'Add product'

    fill_in 'Asin', with: ""

    click_on 'Add'

    expect(page).to have_content 'Asin can not by empty'
  end

  scenario 'user create product with invalid asin' do
    visit products_path
    click_on 'Add product'

    fill_in 'Asin', with: "8K8SR4CC"

    click_on 'Add'

    expect(page).to have_content 'Asin does not exist'
  end

  scenario 'user create product with asin of non-existent goods' do
    visit products_path
    click_on 'Add product'

    fill_in 'Asin', with: "B08K8SR4CP"

    click_on 'Add'

    expect(page).to have_content 'Product does not exist'
  end

end
