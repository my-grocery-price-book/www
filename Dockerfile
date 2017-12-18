# 1: Use ruby 2.4.2 as base:
FROM ruby:2.4.2

RUN apt-get update -q && \
    apt-get install -y \
    build-essential \
    libpq-dev \
    postgresql-client

# for nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs

# 2: We'll set the application path as the working directory
WORKDIR /usr/src/app

# 3: We'll set the working dir as HOME and add the app's binaries path to $PATH:
ENV PATH=/usr/src/app/bin:$PATH

# 7: Install the current project gems - they can be safely changed later during
# development via `bundle install` or `bundle update`:
# ADD Gemfile* /usr/src/app/
# RUN set -ex && bundle install --jobs 2 --retry 3 --clean
