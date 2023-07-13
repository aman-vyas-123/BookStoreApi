Fabricator(:user) do
  name { "MyString" }
  email { "MyString" }
  password { "password" }
  password_confirmation { "password" }
  user_name { sequence(:user_name) { |i| "username#{i}" } }
end