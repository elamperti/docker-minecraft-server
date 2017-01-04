FROM openjdk:alpine
MAINTAINER Enrico Lamperti <elamperti@users.noreply.github.com>

# To specify a different version on build:
#   docker build --build-arg spigot_version=1.10 Dockerfile

ARG spigot_version=latest

# Defaults that can be modified later from compose
# https://www.spigotmc.org/wiki/start-up-parameters/
ENV spigot_eula="false" \
    bukkit_settings="bukkit.yml" \
    spigot_commands="commands.yml" \
    spigot_config="server.properties" \
    spigot_level_name="world" \
    spigot_plugins="plugins" \
    spigot_port="25565" \
    spigot_settings="spigot.yml" \
    spigot_world_dir="./"

# Prepare directory
RUN mkdir -p /base && \
    mkdir -p /minecraft && \
    ln -s /minecraft/server-icon.png /base/server-icon.png

# Tries to copy the jar files from host "jar" directory
# IMPORTANT: This is only done on build, not on container creation,
#            and useful only for speeding the container build.
COPY jar/ /base/

# If spigot jar is not present, download and compile it
RUN [ ! -f /base/spigot*.jar ] && \ 
    mkdir /build && \
    apk update && apk add git openssl ca-certificates bash && \
    update-ca-certificates && \
    cd /build && \
    wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar && \
    bash -c "java -jar BuildTools.jar --rev $spigot_version" && \
    
# Clean up the mess left by the build
    rm /build/BuildTools.jar && \
    mv /build/*.jar /base/ && \
    rm -rf /root/.m2 && \
    rm -rf /build && \
    apk del openssl ca-certificates bash git \
    
# If the build is skipped, print a pretty message
    || echo "Skipping build :)"

COPY entrypoint.sh /base/entrypoint.sh

ENTRYPOINT /base/entrypoint.sh 
