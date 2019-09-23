FROM debian:testing

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Malte Kiefer "maltekiefer1987@gmail.com"

RUN apt-get -qq update && \
    apt-get -qy install gettext-base \
                        python3-markdown python3-pygments \
			markdown fcgiwrap git cgit highlight \
                        ca-certificates nginx gettext-base && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd nginx

EXPOSE 80

RUN mkdir /srv/git

VOLUME ["/srv/git"]
VOLUME ["/var/cache/cgit"]

COPY cgitrc /etc/cgitrc

COPY default.conf /etc/nginx/sites-available/default

CMD service fcgiwrap start && service nginx start && tail -f /var/log/nginx/access.log
