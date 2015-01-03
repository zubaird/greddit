require 'rails_helper'


feature "User Authentication"  do

  scenario "user signs in" do
    sign_in_user

    expect(page).to have_content("you are succesfully logged in")
  end

end
