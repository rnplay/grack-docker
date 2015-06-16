FROM phusion/passenger-ruby22:latest

RUN apt-get install -y git-core
ENV HOME /root
ENV RAILS_ENV production

CMD ["/sbin/my_init"]

RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default

ADD passenger.conf /etc/nginx/sites-enabled/app.conf
ADD nginx_docker_env.conf /etc/nginx/main.d/docker_env.conf

COPY . /app
RUN mkdir -p /app/tmp /app/public

WORKDIR /app

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
