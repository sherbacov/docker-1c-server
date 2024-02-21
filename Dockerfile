FROM sherbacov/1c-server-base:1.17

ADD *.deb /tmp/

ENV PLATFORM_VERSION 8.3.24.1368
ENV SERVER_VERSION 8.3.24.1368
RUN dpkg --install /tmp/*.deb 2> /dev/null \
  && rm /tmp/*.deb \
  && mkdir --parents /var/log/1C /home/usr1cv8/.1cv8/1C/1cv8/conf \
  && chown --recursive usr1cv8:grp1cv8 /var/log/1C /home/usr1cv8

COPY container/docker-entrypoint.sh /
COPY container/logcfg.xml /home/usr1cv8/.1cv8/1C/1cv8/conf

ENTRYPOINT ["/docker-entrypoint.sh"]

VOLUME /home/usr1cv8
VOLUME /var/log/1C

EXPOSE 1540-1541 1560-1591

CMD ["ragent"]
