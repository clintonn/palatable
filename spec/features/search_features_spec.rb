require_relative '../rails_helper.rb'
require 'pry'

describe "Feature Test: Search" do
  it 'allows users to send a search query with a zip code' do
    visit root_path
    fill_in 'search_search', with: 'Speedy Romeo'
    fill_in 'search_location', with: '11205'
    click_button 'Search'
    expect(page).to have_text('Speedy Romeo')
  end

  it 'accepts a neighborhood for a location' do
    visit root_path
    fill_in 'search_search', with: 'Speedy Romeo'
    fill_in 'search_location', with: 'Fort Greene, NY'
    click_button 'Search'
    expect(page).to have_text('Speedy Romeo')
  end
end
