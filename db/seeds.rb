access_profile = AccessProfile.new
access_profile.name = 'Administrator'
access_profile.permissions = { 'access_profiles' => { 'full_access' => '1' }, 'users' => { 'full_access' => '1' } }
access_profile.is_super_profile = true
access_profile.save

# super user
user = User.new
user.first_name = 'Rodrigo'
user.last_name = 'Paszniuk'
user.email = 'rodrigopaszniuk@gmail.com'
user.access_profile_id = 1
user.password = 'holamundo'
user.is_super_user = true
user.save
