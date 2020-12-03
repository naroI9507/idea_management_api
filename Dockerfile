FROM ruby:2.6
RUN apt-get update -qq && apt-get install -y nodejs build-essential libpq-dev yarn
WORKDIR /idea_management_api
COPY Gemfile /idea_management_api/Gemfile
COPY Gemfile.lock /idea_management_api/Gemfile.lock
RUN bundle install
COPY . /idea_management_api

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]