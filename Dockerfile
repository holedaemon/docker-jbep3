FROM cm2network/steamcmd:root as build

LABEL maintainer="m@holedaemon.net"

ENV STEAMAPPID 869800
ENV STEAMAPP jbep3
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

RUN set -x \
    && mkdir -p "${STEAMAPPDIR}" \
    && { \
        echo '@ShutdownOnFailedCommand 1'; \
        echo '@NoPromptForPassword 1'; \
        echo 'force_install_dir '"${STEAMAPPDIR}"''; \
        echo 'login anonymous'; \
        echo 'app_update '"${STEAMAPPID}"''; \
        echo 'quit'; \
    } > "${HOMEDIR}/${STEAMAPP}_update.txt"

COPY --chown=${USER}:${USER} entry.sh server.cfg ${HOMEDIR}/
RUN chown -R "${USER}:${USER}" "${STEAMAPPDIR}" "${HOMEDIR}/${STEAMAPP}_update.txt"

VOLUME ${STEAMAPPDIR}

FROM build as base

ENV SRCDS_PORT=27015 \
    SRCDS_TV_PORT=27020 \
    SRCDS_CLIENT_PORT=27005 \
    SRCDS_LAN="0" \
    SRCDS_MAXPLAYERS=24 \
    SRCDS_RCON_PASSWORD="idiot" \
    SRCDS_SV_PASSWORD="idiot" \
    SRCDS_MAP="crossfire" \
    SRCDS_SV_STEAMACCOUNT="faketokenxDLOL"

USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

EXPOSE 27015/tcp \
    27015/udp \
    27020/udp