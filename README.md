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
    image: holedaemon/jbep3
    container_name: "jb"
    ports:
      - "27015:27015/udp"
      - "27015:27015/tcp"
      - "27020:27020/udp"
    volumes:
      - "$PWD/data:/home/steam/jbep3-dedicated"
    environment:
      SRCDS_SV_STEAMACCOUNT: "xDxddxddxdxd"
```

# License

[GPL](LICENSE)

# Credits

 Big shouts to [CM2Walki](https://github.com/CM2Walki/) for trudging through the shit that is hosting a Source engine game and making it maintainable.