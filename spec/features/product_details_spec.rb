require 'rails_helper'

RSpec.feature "can navigate from home page to product detail page by clicking on a product", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "can click on a product" do
    visit root_path

    # DEBUG
    # puts page.html
    
    # click_on '/products/10'
    find("a[href='/products/10']", match: :first).click

  end
end