FROM ruby:3.3.4
RUN apt-get update -qq && apt-get install -y nodejs yarn
WORKDIR /var/www/
COPY ./Gemfile /var/www/
RUN bundle install -j4

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
