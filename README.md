# Spigot Minecraft server based on Alpine [![Docker Automated build](https://img.shields.io/docker/automated/elamperti/docker-minecraft-server.svg)](https://hub.docker.com/r/elamperti/docker-minecraft-server/)

This image is based on `openjdk:alpine`, adding just ~40 Mb to the total image size with just the required binaries.

## How to use
Start a container based on this image adding the necessary files and folders to `/minecraft` volume and exposing the required ports (usually 25565).

## Disclaimer
Minecraft and Spigot are copyright of their owners; this is just a Dockerfile to facilitate creating a Spigot server. I'm not the owner nor represent Spigot, Minecraft, nor Mojang.

