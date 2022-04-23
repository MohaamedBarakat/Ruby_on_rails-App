FROM ruby:2.7.3

RUN gem install bundler -v 2.1.4

RUN mkdir /backend
WORKDIR /backend

COPY Gemfile Gemfile.lock ./
RUN gem install ovirt-engine-sdk -v '4.3.0' --source 'https://rubygems.org/'

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0","-p","3000"]


