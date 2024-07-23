# Use an official Ruby runtime as a parent image
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install VIPS (required by ruby-vips gem)
RUN apt-get install -y libvips42

# Set the working directory inside the container
WORKDIR /myapp

# Copy the current directory contents into the container at /myapp
COPY . /myapp

# Install any needed gems
RUN bundle install

# Add a script to be executed every time the container starts
COPY bin/docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]