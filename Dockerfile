FROM builddeps-collectd
#ubuntu:12.04

RUN apt-get update && apt-get -y upgrade && apt-get -y install build-essential devscripts equivs apt-utils

RUN rm -rf /tmp/template-control /collectd-build/
ADD ./debian/control /tmp/template-control
RUN mk-build-deps -i -t "apt-get -y --no-install-recommends" /tmp/template-control
RUN rm -f /tmp/template-control

ADD ./ /collectd-build/
WORKDIR /collectd-build/
RUN chmod +x debian/rules
RUN chown -R 0.0 .

CMD /bin/bash --login
