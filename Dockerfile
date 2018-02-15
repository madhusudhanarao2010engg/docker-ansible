FROM ubuntu:trusty
MAINTAINER Thomas Hjert <thomas.hjert@knowit.se>

ENV TERM=xterm-256color

#Set mirrors to SE

RUN sed -i "s/http:\/\/archive./http:\/\/se.archive./g" /etc/apt/sources.list

# Install Phython runtime

RUN apt-get update -qy && \
    apt-get install -qy software-properties-common && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update -qy  && \
    apt-get install -qy ansible

# Copy baked in playbooks
COPY ansible /ansible
COPY ansible/probe.yml /ansible/probe.yml

VOLUME /ansible
WORKDIR /ansible

# Add entrypoint script

ENTRYPOINT ["ansible-playbook"]
CMD ["site.yml"]
