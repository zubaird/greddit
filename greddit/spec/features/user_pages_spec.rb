require 'rails_helper'

def sign_up_user
  visit root_path

  click_link 'Sign Up'

  fill_in('Username', :with => 'test-user')
  fill_in('Email', :with => 'test@example.com')
  fill_in('Password', :with => 'test')
  fill_in('Password confirmation', :with => 'test')

  click_button 'Create User'
end


def sign_in_user
  User.create(
  username:"test-user",
  email:"test@example.com",
  password:"test",
  password_confirmation: "test",
  )

  visit root_path

  click_link 'Sign In'

  fill_in('Email', :with => 'test@example.com')
  fill_in('Password', :with => 'test')

  click_button 'Sign In'
end

feature "User Authentication"  do

  scenario "user signs in" do
    sign_in_user

    expect(page).to have_content("you are succesfully logged in")
  end

end
