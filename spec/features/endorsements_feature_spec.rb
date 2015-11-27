require 'rails_helper'

feature 'endorsing reviews' do
  before do
    kfc = Restaurant.create(name:kfc)
    kfc.reviews.create(rating: 3, thoughts: "It was an abomination")
  end

  scenario 'a user can endorse a review, which updates the review endorsement count' do
    signup_signin
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end
end
