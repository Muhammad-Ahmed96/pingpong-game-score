['inigo', 'edrizio'].each do |u|
  User.create!(name: "#{u}", email: "#{u}@regalii.com", password: 'secret123')
end
puts "-- Added 2 users to your database"
