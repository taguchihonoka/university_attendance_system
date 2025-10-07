FROM ruby:3.4.1

RUN apt-get update -qq

# git
RUN apt-get install -y git --no-install-recommends

# middleware for ruby
RUN apt-get install -y --no-install-recommends \
      libreadline-dev bzip2 build-essential libssl-dev zlib1g-dev libpq-dev libsqlite3-dev \
      curl patch gawk g++ gcc make libc6-dev patch libreadline6-dev libyaml-dev sqlite3 autoconf \
      libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev bison libxslt-dev \
      libxml2-dev default-libmysqlclient-dev unixodbc-dev freetds-dev freetds-bin \
      nodejs openssh-server vim curl wget tcptraceroute

# mysql
RUN apt-get install -y gnupg lsb-release
RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.34-1_all.deb
RUN DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.34-1_all.deb
RUN apt-get update -qq && apt-get install -y mysql-client

# 日本語対応
RUN apt-get install -y --allow-unauthenticated locales-all \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
ENV LANG=ja_JP.UTF-8

# rails install
RUN gem update
RUN gem install rails

