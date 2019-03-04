FROM ruby:2.6.0-alpine

RUN apk --no-cache --virtual add alpine-sdk sqlite-dev sqlite

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile .
RUN bundle install && bundle clean

COPY ./setup.sql /app/
RUN sqlite3 test.db < setup.sql

COPY ./app.rb /app/
CMD ["ruby", "app.rb"]