FROM cpuguy83/ubuntu
ENV SERVER_ID 1

RUN apt-get update
RUN apt-get install -y mysql-server


RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
RUN mkdir -p /var/log/mysql && chown -R mysql.mysql /var/log/mysql

ADD mysql_start /usr/local/bin/
RUN chown mysql.mysql /usr/local/bin/mysql_start
ENTRYPOINT ["/usr/local/bin/mysql_start", "--relay-log=mysqld-relay-bin"]
CMD [""]

EXPOSE 3306
VOLUME /var/log
VOLUME /var/lib/mysql

