# Dockerfile
# /path/to/your/app/Dockerfile
FROM repo.forge.lmig.com/docker/ruby:2.5.8

RUN apt-get update -qq && apt-get install -y nodejs

RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential libpq-dev nodejs libc6-dev wget


WORKDIR /tmp


# Setup FreeTDS - this is only needed for SQL Server, this can be removed when moving to postgres
RUN gem install bundler

# Cache Gems
ADD Gemfile .
ADD Gemfile.lock .

RUN bundle install --jobs 4

# Copy your app's code into the image
WORKDIR /usr/src/app
ADD . /usr/src/app

