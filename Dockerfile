FROM ubuntu:16.04
MAINTAINER David Handy <david@david-handy.com>

RUN apt-get -y update && apt-get -y upgrade && apt-get -y clean
RUN apt-get -y install sane sane-utils netpbm wget x11-common- && apt-get -y clean

RUN wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs952/ghostscript-9.52-linux-x86_64.tgz
RUN tar xvf ghostscript-9.52-linux-x86_64.tgz
RUN cp ghostscript-9.52-linux-x86_64/gs-952-linux-x86_64 /usr/bin/gs
RUN gs -v

ADD drivers /opt/brother/docker_skey/drivers
RUN dpkg -i /opt/brother/docker_skey/drivers/*.deb

ADD config /opt/brother/docker_skey/config
ADD scripts /opt/brother/docker_skey/scripts

RUN cfg=`ls /opt/brother/scanner/brscan-skey/brscan-skey-*.cfg`; ln -sfn /opt/brother/docker_skey/config/brscan-skey.cfg $cfg

CMD /opt/brother/docker_skey/scripts/start.sh
