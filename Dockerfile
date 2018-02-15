FROM ubuntu:trusty
MAINTAINER Thomas Hjert <thomas.hjert@knowit.se>

ENV TERM=xterm-256color

#Set mirrors to SE
RUN sed -i "s/http:\/\/archive./http:\/\/se.archive./g" /etc/apt/sources.list

# Install Ansible

RUN apt-get update -qy && \
    apt-get install -qy software-properties-common && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update -qy  && \
    apt-get install -qy ansible && \
    apt-get install -qy  bash && \
    apt-get install -qy  curl && \
    apt-get install -qy  tar && \
    apt-get install -qy  openssh-client && \
    apt-get install -qy  sshpass && \
    apt-get install -qy  git && \
    apt-get install -qy  python && \
    apt-get install -qy  python && \
    apt-get install -qy  python-virtualenv && \
    apt-get install -qy  libpython2.7 && \
    apt-get install -qy  python-mysqldb

# Copy baked in playbooks
COPY ansible /ansible
###COPY ansible/probe.yml /ansible/probe.yml

 
RUN echo "[local]" >> /etc/ansible/hosts && \
  echo "localhost" >> /etc/ansible/hosts

VOLUME /ansible
WORKDIR /ansible/ansible

# Add entrypoint script

ENTRYPOINT ["ansible-playbook"]
CMD ["probe.yml"]
###ENTRYPOINT ["/bin/ls","-R","/ansible"]
###CMD ["localhost"]
