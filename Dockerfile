FROM ubuntu:20.04
MAINTAINER David Handy <david@david-handy.com>

RUN apt-get -y update && apt-get -y upgrade && apt-get -y clean
RUN apt-get -y install sane sane-utils ghostscript netpbm x11-common- && apt-get -y clean

ADD drivers /opt/brother/docker_skey/drivers
RUN dpkg -i /opt/brother/docker_skey/drivers/*.deb

ADD config /opt/brother/docker_skey/config
ADD scripts /opt/brother/docker_skey/scripts

RUN cfg=`ls /opt/brother/scanner/brscan-skey/brscan-skey-*.cfg`; ln -sfn /opt/brother/docker_skey/config/brscan-skey.cfg $cfg

CMD /opt/brother/docker_skey/scripts/start.sh
