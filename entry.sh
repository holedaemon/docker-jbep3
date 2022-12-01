#!/bin/bash
bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
    +login anonymous \
    +app_update "${STEAMAPPID}" \
    +quit

if [ ! -f "${STEAMAPPDIR}/${STEAMAPP}/cfg/server.cfg" ]; then
    cp "${HOMEDIR}/server.cfg" "${STEAMAPPDIR}/${STEAMAPP}/cfg/server.cfg"
fi

cd "${STEAMAPPDIR}"

bash "${STEAMAPPDIR}/srcds_run.sh" \
    -game "${STEAMAPP}" \
    -console \
    -autoupdate \
    -steam_dir "${STEAMCMDDIR}" \
    -steamcmd_script "${HOMEDIR}/${STEAMAPP}_update.txt" \
    -port "${SRCDS_PORT}" \
    -sv_steamaccount "${SRCDS_SV_STEAMACCOUNT}" \
    +tv_port "${SRCDS_TV_PORT}" \
    +clientport "${SRCDS_CLIENT_PORT}" \
    +maxplayers "${SRCDS_MAX_PLAYERS}" \
    +map "${SRCDS_MAP}" \
    +sv_lan "${SRCDS_LAN}" \
    +sv_password "${SRCDS_SV_PASSWORD}" \
    +rcon_password "${SRCDS_RCON_PASSWORD}" \
    ${SRCDS_CUSTOM_ARGS}
