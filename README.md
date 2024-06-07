# Hotefinder

Hotefinder is an app to link home owners and hosts.

## Versions

**Ruby**: 3.2.2\
**Rails**: 7.1.4

## Contributors

- Elias Ben Amar
- Antoine Kim Cheang
- Enzo Garry
- Valentin Orrit

## Installation
### System Dependencies

Ensure you have the following installed:

- Ruby 3.2.2
- Rails 7.1.4
- tailwindCSS
- PostgreSQL
- Node.js and Yarn (for JavaScript dependencies)
- libvips (for ActiveStorage)

### Configuration

Clone the repository and navigate into the project directory:

```sh
git clone <repository_url>
cd hotefinder
```

### Database Creation

Set up the database by running:

```sh
rails db:create
```

### Database Initialization

Migrate the database and seed it with initial data:

```sh
rails db:migrate
rails db:seed
```

### Services

This app uses Active Storage for file uploads. Ensure your environment variables are correctly set for these services, especially for S3 storage.

### Local Server
Run on the local server
```
bin/dev
```

### Deployment Instructions

...

### Additional Notes

...

## License

...