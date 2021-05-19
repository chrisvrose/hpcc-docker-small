FROM ubuntu:bionic

# lets get apt installed 
RUN apt-get update && apt-get install -y wget ca-certificates iputils-ping curl xterm
# RUN apt-get update && apt-get install -y --no-install-recommends \
# 		ca-certificates       \
# 		wget                  \
#                 libaprutil1           \
#                 libboost-regex1.58.0  \
#                 libicu55              \
#                 libldap-2.4-2         \
#                 libtbb2               \
#                 libnuma1              \
#                 libxml2               \
#                 libxslt1.1            \
#                 g++                   \
#                 openssh-client        \
#                 openssh-server        \
#                 expect                \
#                 rsync                 \
#                 python                \
#                 sudo                  \
#                 libblas3              \
#                 libatlas3-base        \
#                 psmisc                \
#                 libmemcached11        \
#                 libmemcachedutil2     \
#                 libpython2.7          \
#                 libpython3.5          \
#                 vim                   \
#                 net-tools             \
#                 --fix-missing         \
# 	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/dbus && mkdir -p /var/run/sshd

RUN groupadd hpcc && useradd -s /bin/bash -r -m -d /home/hpcc -g hpcc -c "hpcc Runtime User" hpcc

ENV VERSION 8.0.12
ENV FULL_VERSION 8.0.12-1
#ENV PLATFORM_DOWNLOAD_MD5  ef58e94dcc66a45cb0fc8202e68b50d9
ENV PLATFORM_PACKAGE hpccsystems-platform-community_${FULL_VERSION}bionic_amd64.deb



# https://cdn.hpccsystems.com/releases/CE-Candidate-8.0.12/bin/platform/hpccsystems-platform-community_8.0.12-1bionic_amd64.deb
RUN set -x \
   &&  wget  "https://cdn.hpccsystems.com/releases/CE-Candidate-${VERSION}/bin/platform/${PLATFORM_PACKAGE}" \
   #&& echo "$PLATFORM_DOWNLOAD_MD5 ${PLATFORM_PACKAGE}" | md5sum -c - \
   && apt install -y  ./"${PLATFORM_PACKAGE}" \
   && rm -rf "${PLATFORM_PACKAGE}" && rm -rf /var/lib/apt/lists/*

EXPOSE 22 8010 8002 8015 9876

RUN cp -r /home/hpcc/.ssh ~/

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]