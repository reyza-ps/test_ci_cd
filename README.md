# Ocpi Hub

Project OCPI Hub

# Requirement

- Ruby 3.2.2
- Rails 7.0.7
- Postgresql 15

# Installation

1. Clone the repository
2. Run

    $ bundle install

3. Create development environment from credentials.example

    $ rails credentials:edit --environment development

4. Prepare database

    $ rails db:create db:migrate

# Local development

1. Install foreman

    $ gem install foreman

2. Start server

    $ ./bin/dev

# OCPI

You can create your first token A from rails console :

```
token_a = Ocpi::Domain::Credentials::Repositories::GenerateTokenA.new.call
token_a.token
```

Visit swagger docs at http://localhost:3000/swagger-ocpi/doc for documentation

