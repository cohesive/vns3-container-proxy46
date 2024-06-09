FROM vns3local:vns3_base
SHELL ["/bin/bash", "-c"]
MAINTAINER @cohesivenet

RUN apt update && apt clean
RUN apt update && \
    apt install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt update && \
    apt install -y nano vim wget curl less sudo python3 python3-pip python3-virtualenv virtualenv && \
    apt autoremove && \
    apt clean && \
    mkdir -p /opt/plugin-manager/ && \
    mkdir -p /opt/cohesive/ && \
    mkdir -p /opt/proxy46

ADD get4for6 /opt/proxy46/
ADD get4for6.default.conf /opt/proxy46/proxy46.conf

ADD ./container_shutdown.sh /opt/cohesive/
ADD ./pm_config.json /opt/plugin-manager/config.json

ADD ./supervisor_configs/proxy46.conf /etc/supervisor/conf.d/

RUN chmod +x /opt/cohesive/container_shutdown.sh

CMD ["mkdir -p /mnt/logs/plugins/proxy46 && /usr/bin/supervisord"]
