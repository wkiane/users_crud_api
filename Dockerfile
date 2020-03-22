FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client


RUN mkdir /app
WORKDIR /app
COPY app/Gemfile /app/Gemfile
COPY app/Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY app /app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
CMD ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]