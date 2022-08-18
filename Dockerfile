FROM ruby:3.0

RUN apt-get update && apt-get install -y nodejs yarn

RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY . .

RUN rake assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
