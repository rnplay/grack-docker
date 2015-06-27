FROM ruby:2.2-onbuild


RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y git-core nodejs

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV RACK_ENV production

EXPOSE 80

ENTRYPOINT ["bundle", "exec", "rackup"]

CMD ["--host", "0.0.0.0", "-p", "80", "-s", "thin", "-O", "user=app", "config.ru"]
