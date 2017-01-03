FROM openjdk:alpine
MAINTAINER Enrico Lamperti <elamperti@users.noreply.github.com>

# To specify a different version on build:
#   docker build --build-arg spigot_version=1.10 Dockerfile

ARG spigot_version=latest

VOLUME /minecraft

# Prepare directory
RUN mkdir -p /base 

# Tries to copy the jar files from host "jar" directory
# IMPORTANT: This is only done on build, not on container creation,
#            and useful only for speeding the build.
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
    apk del openssl ca-certificates bash git 

COPY entrypoint.sh /base/entrypoint.sh

ENTRYPOINT /base/entrypoint.sh 
