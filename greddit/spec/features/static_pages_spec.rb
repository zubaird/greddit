require 'rails_helper'

feature "Home Page" do

  scenario "Homepage works" do
    visit root_path

    expect(page).to have_content("Welcome")
  end

  scenario "when sign in is clicked" do
    visit root_path

    click_link "Sign Up"

    expect(page).to have_content "Register"
  end

end

feature do

  scenario do
    # => set up

    # => do the thing

    # => Expectations
  end
end
