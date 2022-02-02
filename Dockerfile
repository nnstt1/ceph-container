FROM centos:centos8 AS builder
RUN sed -i 's/#baseurl=http:\/\/mirror.centos.org/baseurl=http:\/\/vault.centos.org/' /etc/yum.repos.d/CentOS-Linux-AppStream.repo && \
    sed -i 's/#baseurl=http:\/\/mirror.centos.org/baseurl=http:\/\/vault.centos.org/' /etc/yum.repos.d/CentOS-Linux-BaseOS.repo && \
    sed -i 's/#baseurl=http:\/\/mirror.centos.org/baseurl=http:\/\/vault.centos.org/' /etc/yum.repos.d/CentOS-Linux-Extras.repo && \
    yum install -y git zip automake pcre-devel gcc make && \
    git clone https://git.zabbix.com/scm/zbx/zabbix.git -b 5.4.10 --depth 1
WORKDIR /zabbix/
RUN ./bootstrap.sh && \
    ./configure --enable-agent --disable-dependency-tracking && \
    make && \
    make install

FROM quay.io/ceph/ceph:v16.2.7
COPY --from=builder /usr/local/bin/zabbix_sender /usr/bin/zabbix_sender