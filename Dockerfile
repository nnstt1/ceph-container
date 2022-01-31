FROM quay.io/ceph/ceph:v16.2.7

RUN dnf install -y https://repo.zabbix.com/zabbix/5.4/rhel/8/x86_64/zabbix-release-5.4-1.el8.noarch.rpm --disablerepo=appstream,baseos,extras && \
    dnf install -y zabbix-sender --disablerepo=appstream,baseos,extras && \
    dnf clean all