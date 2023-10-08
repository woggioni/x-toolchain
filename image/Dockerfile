FROM debian:12
MAINTAINER Oggioni Walter <oggioni.walter@gmail.com>
RUN apt-get update 
RUN apt-get -y install libtool-bin build-essential git autoconf gcc gperf bison flex texinfo rsync
RUN apt-get -y install pkg-config help2man make libncurses5-dev python3-dev bzip2 xz-utils gawk wget curl unzip
RUN useradd luser -s /bin/bash -m -G users
WORKDIR /tmp
RUN git clone "https://github.com/crosstool-ng/crosstool-ng.git"
WORKDIR crosstool-ng
RUN git checkout "crosstool-ng-1.26.0"
RUN ./bootstrap
RUN ./configure --prefix=/opt/xng
RUN make
RUN make install
WORKDIR /tmp
RUN rm -r crosstool-ng
COPY ccache-build.sh /tmp/ccache-build.sh
RUN /bin/bash /tmp/ccache-build.sh
RUN rm -rf /tmp/ccache-build.sh /tmp/ccache-build
RUN apt-get clean
COPY ccache.conf /etc/ccache.conf
USER luser

