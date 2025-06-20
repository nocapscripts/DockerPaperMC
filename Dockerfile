# Use Ubuntu with Java 21
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PAPER_VERSION=1.21.4
ENV PAPER_BUILD=232

# Update and install required packages
RUN apt-get update && apt-get install -y \
    openjdk-21-jdk \
    curl \
    sudo \
    openssh-server \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# Set up SSH
RUN mkdir /var/run/sshd

# Create users and set passwords
RUN useradd -m -s /bin/bash manager && \
    useradd -m -s /bin/bash admin && \
    echo 'root:IsAdmin12345.' | chpasswd && \
    echo 'admin:IsAdmin12345.' | chpasswd && \
    usermod -aG sudo admin && \
    usermod -aG sudo root

# Create Minecraft working directory under admin's home
WORKDIR /home/admin/papermc

# Create plugin directory and copy plugin jar
RUN mkdir -p plugins
COPY plugins/* ./plugins/

# Download PaperMC jar
RUN curl -o paper.jar https://api.papermc.io/v2/projects/paper/versions/${PAPER_VERSION}/builds/${PAPER_BUILD}/downloads/paper-${PAPER_VERSION}-${PAPER_BUILD}.jar

# Copy EULA and startup script
COPY eula.txt .
COPY start.sh /home/admin/papermc/start.sh
RUN chmod +x /home/admin/papermc/start.sh

# Ensure admin owns the whole folder
RUN chown -R admin:admin /home/admin/papermc

# Expose Minecraft and SSH ports
EXPOSE 25565 22

# Set startup script
CMD ["/home/admin/papermc/start.sh"]
