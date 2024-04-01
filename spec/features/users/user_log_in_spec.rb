require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(name: "funbucket13",email: "alex@123.com", password: "test")

    visit root_path

    click_on "Log in"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password
   


    click_on "Log In"
    
    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome, #{user.name}!")
    
  end

  it "can log in with valid credentials" do
    user = User.create(name: "funbucket13",email: "alex@123.com", password: "test")

    visit root_path

    click_on "Log in"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: "1234"
   


    click_on "Log In"
    
    expect(current_path).to eq(login_path)

    expect(page).to have_content("Sorry, your credentials are bad.")
   
  end
end
