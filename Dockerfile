FROM ruby:2.6.0-alpine

RUN apk update && apk upgrade && apk add docker
WORKDIR /app
COPY Gemfile .
RUN bundle install && bundle clean
COPY . /app
EXPOSE 80
CMD ["ruby", "app.rb", "-o", "0.0.0.0", "-p", "80"]