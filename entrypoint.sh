#!/bin/sh

# Provide a way to get the jars out of the container
ln -s /base/*.jar /minecraft/

# Start Minecraft server
cd /minecraft && java -jar spigot*.jar
