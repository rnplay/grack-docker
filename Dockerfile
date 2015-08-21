FROM ruby:2.2

RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y git-core nodejs

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -ms /bin/bash -u 9999 app
RUN mkdir -p /usr/src/app
RUN chown -R app /usr/src/app

WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app

ENV RACK_ENV production

EXPOSE 8000

USER app

ENTRYPOINT ["bundle", "exec", "rackup"]

CMD ["--host", "0.0.0.0", "-p", "8000", "-s", "thin", "-O", "user=app", "config.ru"]
