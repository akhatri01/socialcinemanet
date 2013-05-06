namespace :parse do
  
  desc "Create fake users."
  # run 'rake parse:add_ratings
  task :create_fake_users => :environment do
    1000.times do
      user = User.new
      user.fname = Forgery::Name.first_name
      user.mname = Forgery::Name.first_name
      user.lname = Forgery::Name.last_name
      user.dob = Forgery::Date.year.to_s + "-" + Forgery::Date.month.to_s + "-" + Forgery::Date.day.to_s
      user.email = Forgery::Internet.email_address
      user.password = Forgery::Basic.password
      user.save
    end
  end
end