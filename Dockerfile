FROM ruby:2.6.0-alpine

RUN apk update && apk upgrade && apk add docker && apk add build-base gcc
WORKDIR /app
COPY Gemfile .
RUN bundle install && bundle clean
COPY . /app
EXPOSE 8080
CMD ["ruby", "app.rb", "-o", "0.0.0.0", "-p", "8080"]
