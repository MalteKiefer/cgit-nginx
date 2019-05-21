FROM debian:testing

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Malte Kiefer "malte.kiefer@mailgermania.de"

RUN apt-get -qq update && \
    apt-get -qy install vim gettext-base \
                        fcgiwrap git cgit highlight \
                        ca-certificates nginx gettext-base \
                        markdown python-docutils python-pygments groff && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd nginx

EXPOSE 80

RUN mkdir /srv/git

VOLUME ["/srv/git"]
VOLUME ["/var/cache/cgit"]

COPY cgitrc /etc/cgitrc

COPY default.conf /etc/nginx/sites-available/default

CMD service fcgiwrap start && service nginx start && tail -f /var/log/nginx/access.log
