# 1: Use ruby base:
FROM ruby:2.4.10

ARG UNAME=dev
ARG UID=1000
ARG GID=1000

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" >> /etc/apt/sources.list.d/pgdg.list && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update  -q --fix-missing && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    postgresql-client-12 \
    nodejs \
    yarn \
    cmake \
    && apt-get clean

# add phantomjs
RUN curl --output /usr/local/bin/phantomjs https://s3.amazonaws.com/circle-downloads/phantomjs-2.1.1
RUN chmod a+x /usr/local/bin/phantomjs

# 2: We'll set the application path as the working directory
WORKDIR /usr/src/app

# 3: add the app's binaries path to $PATH:
ENV PATH=/usr/src/app/bin:$PATH

# 7: Install the current project gems - they can be safely changed later during
# development via `bundle install` or `bundle update`:
# ADD Gemfile* /usr/src/app/
# RUN set -ex && bundle install --jobs 2 --retry 3 --clean

RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
USER $UNAME
