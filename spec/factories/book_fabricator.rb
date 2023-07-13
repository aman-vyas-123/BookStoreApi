Fabricator(:book) do
  title { sequence(:title) { |i| "title#{i}" } }
  author { 'Author 1' }
  price { '9.99' }
  published_at { '2023-07-12' }
  user { Fabricate(:user) }
end