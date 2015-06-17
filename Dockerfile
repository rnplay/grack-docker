FROM ruby:2.2-onbuild

RUN apt-get install -y git-core
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV RACK_ENV production

ENTRYPOINT ["bundle", "exec", "rackup"]

CMD ["--host", "0.0.0.0", "-p", "80", "-s", "thin", "config.ru"]
