FROM ghcr.io/ba-st/pharo-loader:v10.0.1 AS loader
RUN pharo metacello install github://ctSkennerton/baby_tracker:master BaselineOfBabyTracker

FROM ghcr.io/ba-st/pharo:v10.0.1
WORKDIR /opt/pharo/
COPY --from=loader /opt/pharo/Pharo.image ./
COPY --from=loader /opt/pharo/Pharo.changes ./
COPY --from=loader /opt/pharo/Pharo*.sources ./

EXPOSE 1701

USER root
RUN apt-get update && apt-get install -y sqlite3
ENV TZ="America/Los_Angeles"

USER pharo
COPY run.st /opt/pharo
COPY pharo.conf /etc/security/limits.d/pharo.conf
# The sqlite3 database will be written into this directory
RUN mkdir /opt/pharo/data
ENTRYPOINT ["pharo", "/opt/pharo/Pharo.image", "--no-quit", "st", "/opt/pharo/run.st" ] 
