# docker-jbep3

A containerized version of the [Jabroni Brawl: Episode 3](https://store.steampowered.com/app/869480/Jabroni_Brawl_Episode_3/) dedicated server software. Mostly just a Frankenstein'd version of [CM2Walki/CSGO](https://github.com/CM2Walki/CSGO).

# Running

Assuming you want to persist the server and its data between restarts (duh), you'll need to create the mountpoint before running the container. Do not let the container create the mountpoint or the server will be installed in the wrong location.

```sh
$ mkdir data
```

Then simply

```yml
version: "3"

services:
  jb:
    image: ghcr.io/holedaemon/jbep3
    container_name: "jb"
    env_file: .env
    ports:
      - "27015:27015/udp"
      - "27015:27015/tcp"
      - "27020:27020/udp"
    volumes:
      - "$PWD/data:/home/steam/jbep3-dedicated"
```

# Environment
Customizable environment variables you can use to tweak SRCDS arguments. Feel free to PR or fork if one you need is missing and not otherwise configurable.

```dockerfile
SRCDS_PORT=27015
SRCDS_TV_PORT=27020
SRCDS_CLIENT_PORT=27005
SRCDS_LAN="0" # Change to 1 to run in LAN mode
SRCDS_MAXPLAYERS=24
SRCDS_RCON_PASSWORD="idiot" # Can be overwritten by server.cfg
SRCDS_SV_PASSWORD="idiot" # Can be overwritten by server.cfg
SRCDS_MAP="crossfire" # Map to start on
SRCDS_SV_STEAMACCOUNT="faketokenxDLOL" # GSLT; enables your server to appear in the server browser with default filters
```

# License

[GPL](LICENSE)

# Credits

Big shouts to

 * [CM2Walki](https://github.com/CM2Walki/) for trudging through the shit that is hosting a Source engine game and making it maintainable.

* The [dedicated server Steam guide](https://steamcommunity.com/sharedfiles/filedetails/?id=1527732439) for giving me a starting basis, etc.