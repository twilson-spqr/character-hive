require 'rails_helper'

feature 'sign in', %(
  As a user
  I want to sign in
  So that I can submit awesome review reviews
) do

  scenario 'user successfully signs in' do
    user = FactoryBot.create(:user)
    visit root_path
    click_link 'Sign In'

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password

    click_button 'Sign In'

    expect(page).to have_content('Welcome back to the Hive!')
    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')
  end

  scenario 'a non-existent attempts to sign in' do
    visit new_user_session_path

    fill_in 'user[email]', with: 'Steve'
    fill_in 'user[password]', with: 'Dragonborn1234'
    click_button 'Sign In'

    expect(page).to have_content('Invalid Email or password')
    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an existing user with the wrong password tries to sign in' do
    user = FactoryBot.create(:user)
    visit new_user_session_path

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: "Idontwanna"
    click_button 'Sign In'

    expect(page).to have_content('Invalid Email or password')
    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'A user cannot sign in when already in' do
    user = FactoryBot.create(:user)
    visit new_user_session_path

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Welcome back to the Hive!')
    expect(page).to_not have_content('Sign In')

    visit new_user_session_path

    expect(page).to have_content('You are already signed in')
  end
end
