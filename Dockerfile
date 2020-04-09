# Use ruby image to build our own image
FROM ruby:2.7

RUN apt-get update && apt-get install -y \
    vim nano \
    imagemagick

# We specify everythink will happen within the /app folder in the container
WORKDIR /blog_api

# We copy these files from our current application to the /app container
COPY Gemfile Gemfile.lock /blog_api/

# We install all the dependencies
RUN bundle install

# We copy all the files from our current application to the /app container
COPY . .

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
