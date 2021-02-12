FROM codercom/code-server:latest

USER coder

# Apply VS Code settings
COPY settings.json .local/share/code-server/User/settings.json

# Use bash shell
ENV SHELL=/bin/bash

# Ensure it runs on port 80
ENV PORT=80

# Use our custom entrypoint script first
COPY azure-entrypoint.sh /usr/bin/azure-entrypoint.sh

USER root
# Add support for SSHing into the app (https://docs.microsoft.com/en-us/azure/app-service/configure-custom-container?pivots=container-linux#enable-ssh)
RUN sudo apt-get update && apt-get install -y openssh-server \
     && echo "root:Docker!" | chpasswd 
COPY sshd_config /etc/ssh/
EXPOSE 80 2222

# Fix permissions
RUN chown -R coder:coder /home/coder

# Fix SSH bug
RUN mkdir -p /var/run/sshd

RUN mkdir /home/coder/project

ENTRYPOINT ["/usr/bin/azure-entrypoint.sh"]