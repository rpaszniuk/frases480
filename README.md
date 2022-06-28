# Frases 480
Frases 480 is a project that aims to create a crowdsourced database of phrases.


## Project Parts
* WEB (show phrases / categories) - Demo: https://www.frases480.com
* CMS (manage phrases / categories) - Demo: https://cms.frases480.com
* API (manage phrases / categories) - Demo: https://api.frases480.com

## Requirements

### Main Requirements
* Rails 6.1.4
* Ruby 3.0.0
* NodeJS 12
* Yarn >= 1
* MariaDB >= 10.4

## Instructions

```
git clone https://github.com/rpaszniuk/frases480.git
rake app:update:bin
bundle install
./bin/rails webpacker:install
```

Configurate credentials: bin/rails credentials:edit

```
secret_key_base: 

name: 'Frases 480'
emails:
  admin: ''
  no_reply: ''
sendgrid:
  api_key: ''
  sandbox: false
  templates:
    password_recovery: ''
cookie_domain: ''
web_host: ''
api_host: ''
cms_domain: ''
app_secret: ''
rswag:
  username: ''
  password: ''
redis:
  host: 'localhost'
  port: 6379
```

Configurate database (Example config/database_sample.yml)

```
rake db:create
rake db:migrate
rake db:seed
```

## RSpec (testing tool for Ruby)

- bundle exec rspec

## API Documentation

To generate swagger documentation first create a test database then run `rake rswag:specs:swaggerize`

You should be able to see the documentation at `/api-docs`

## TODO

- Migrate to Rails 7
- Add more Unit tests
- Finish Documentation (APIs, Configuration Options)

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

## License

This project is licensed under the terms of the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details
