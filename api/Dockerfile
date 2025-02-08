FROM ruby:3.0.6
RUN apt-get update -qq && apt-get install -y nodejs
WORKDIR /qiita-kenny
COPY Gemfile /qiita-kenny/Gemfile
COPY Gemfile.lock /qiita-kenny/Gemfile.lock
RUN bundle install
COPY . /qiita-kenny/
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]