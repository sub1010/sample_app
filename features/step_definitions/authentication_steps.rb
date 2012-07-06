 Given /^a user visits the signin page$/ do
  visit signin_path
end        

When /^he submits invalid signin information$/ do
 click_button "Sign In"
end   

Then /^he should see an error message$/ do
  should have_selector('div.alert.alert-error', text: 'Invalid')
end
                                                

Given /^the user has an account$/ do
  @user = User.create(name: "Example User", email: "user@example.org" , password: "foobar" , password_confirmation: "foobar")
end


Given /^the user submits valid signin information$/ do
  fill_in "Email", with: user.name
   fill_in "Password" , with: user.password
   click_button "Sign In"
end

Then /^he should see his profile page$/ do
 should have_selector('title', text: @user.name)
end

Then /^he should see a signout link$/ do
  should have_link ('Sign In')
end
