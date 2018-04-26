FROM debian:8
MAINTAINER Oggioni Walter <oggioni.walter@gmail.com>
RUN apt-get update 
RUN apt-get -y install libtool-bin build-essential git ccache autoconf gcc gperf bison flex texinfo help2man make libncurses5-dev python-dev bzip2 xz-utils gawk wget curl
RUN useradd luser -s /bin/bash -m -G users
WORKDIR /tmp
RUN git clone "https://github.com/crosstool-ng/crosstool-ng"
WORKDIR crosstool-ng
RUN ./bootstrap
RUN ./configure --prefix=/opt/xng
RUN make
RUN make install
WORKDIR /tmp
RUN rm -r crosstool-ng
RUN apt-get clean
USER luser

