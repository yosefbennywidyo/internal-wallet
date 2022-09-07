# Internal Wallet

## Requirements

- Ruby: 3.1.0
- Rails: 7.0.2.3
- database: Postgres
- node: 16.4.1
- npm: 7.18.1
- yarn: 3.2.3
- foreman: 0.87.2

## Run

```bash
rails db:seed
foreman start -f Procfile.dev
```

## Test

```bash
bundle exec rspec
```