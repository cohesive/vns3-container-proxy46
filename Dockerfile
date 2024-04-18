FROM vns3local:vns3_base_18
SHELL ["/bin/bash", "-c"]
MAINTAINER @cohesivenet

RUN apt update && apt clean
RUN apt update && \
    apt install -y nano vim wget curl less sudo python3 python3-pip python3-virtualenv virtualenv && \
    apt autoremove && \
    apt clean && \
    mkdir -p /opt/plugin-manager/ && \
    mkdir -p /opt/cohesive/ && \
    cd /opt && \
    git clone https://github.com/cohesive/vns3-container-proxy46.git /opt/proxy46 && \
    cat get4for6.example.toml | grep -v "^#" | tr -s '\n' > /opt/proxy46/proxy46.conf

ADD ./container_shutdown.sh /opt/cohesive/
ADD ./pluginmanager_config.json /opt/plugin-manager/config.json

ADD ./helloworld/helloworld.sh /opt/helloworld/
ADD ./helloworld/helloworld.conf /opt/helloworld/
ADD ./helloworld/setup.sh /opt/helloworld/

ADD ./supervisor_configs/helloworld.conf /opt/helloworld/
ADD ./supervisor_configs/autoconf.conf /etc/supervisor/conf.d/

# ADD ./binaries/binary /usr/sbin/

RUN ln -s /opt/helloworld/setup.sh /home/container_admin/setup.sh && \
    ln -s /opt/helloworld/helloworld.conf /home/container_admin/helloworld.conf && \
    chmod +x /opt/autoconf/autoconf.sh && \
    chmod +x /opt/cohesive/container_shutdown.sh && \
    chmod +x /opt/helloworld/setup.sh && \
    chmod +x /opt/helloworld/helloworld.sh
