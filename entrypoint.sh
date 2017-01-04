#!/bin/sh

# Start Minecraft server
# shellcheck disable=SC2154 
cd /base && java -Dcom.mojang.eula.agree=${spigot_eula} -jar spigot*.jar \
  --bukkit-settings "${bukkit_settings}" \
  --commands-settings "${spigot_commands}" \
  --config "${spigot_config}" \
  --level-name "${spigot_level_name}" \
  --plugins "${spigot_plugins}" \
  --port "${spigot_port}" \
  --spigot-settings "${spigot_settings}" \
  --world-dir "${spigot_world_dir}"
