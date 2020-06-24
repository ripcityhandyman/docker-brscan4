FROM ubuntu:16.04
MAINTAINER David Handy <david@david-handy.com>

RUN apt-get -y update && apt-get -y upgrade && apt-get -y clean
RUN apt-get -y install sane sane-utils netpbm wget tzdata x11-common- && apt-get -y clean

RUN wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs952/ghostscript-9.52-linux-x86_64.tgz
RUN tar xvf ghostscript-9.52-linux-x86_64.tgz
RUN rm ghostscript-9.52-linux-x86_64.tgz
RUN mv ghostscript-9.52-linux-x86_64/gs-952-linux-x86_64 /usr/bin/gs

ADD drivers /brscan-skey/drivers
RUN dpkg -i /brscan-skey/drivers/*.deb

CMD /brscan-skey/scripts/start.sh
