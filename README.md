# Frases 480
Frases 480 is a project that aims to create a crowdsourced database of phrases.


## Project Parts
* WEB (show phrases / categories) - Demo: https://www.frases480.com
* CMS (manage phrases / categories) - Demo: https://cms.frases480.com
* API (manage phrases / categories) - Demo: https://api.frases480.com

## Requirements

### Main Requirements
* Ruby 2.6+
* MariaDB 10.4+
* Redis 2.2+
* Rails 6.0+


## Instructions

```
git clone https://github.com/rpaszniuk/frases480.git
rake app:update:bin
bundle install
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
cms_domain: ''
app_secret: ''
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

## Optional

MariaDB is recommended but you can use any database supported by Rails (e.g. Postgres, SQLite)

## TODO

- ~Ruby 2.6 support~
- ~Rails 6 support~
- Unit tests
- Documentation(APIs, Configuration Options)

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

## License

This project is licensed under the terms of the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details
