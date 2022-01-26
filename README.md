# Project MAS 2022

A slightly adjusted version of the Project MAS 2022 template.

- Docker is made ✨ optional ✨
- Browser connects to [Thunderstruck](https://github.com/m-rots/thunderstruck)
- Begone Text-to-Speech
- Automatic and instant device selection

## Dependencies

The project dependencies have been significantly reduced to:

- [Thunderstruck](https://github.com/m-rots/thunderstruck) (WIP)
- Eclipse with the GOAL plug-in
- Redis

### macOS

Students running macOS (35% in 2022) can install Redis and Thunderstruck through [Homebrew](https://brew.sh):

```
brew tap m-rots/project-mas
brew install redis thunderstruck
```

To start Redis on boot, you can enable the Redis service:

```
brew services start redis
```

Once you're no longer following this course. You can disable and remove these dependencies by running:

```
brew services stop redis
brew rm redis thunderstruck
```

### Docker

Students running Windows (55% in 2022) or Linux (1% in 2022) can install Redis and Thunderstruck through [Docker](https://www.docker.com/get-started).
Clone this repository, cd into it and then run:

```
docker-compose up -d
```

This command will create and run two services in the background: Redis and Thunderstruck.

You can also manually start Redis by running:

```
docker run -d -p=6379:6379 \
    --restart=unless-stopped \
    --name=sic \
    redis:alpine
```

_Note: currently the Docker Compose template only starts the Redis service. Thunderstruck does not (yet) offer a Docker image._

## Future work

### Redis TLS

The GOAL connector currently relies on a Redis TLS connection.
By removing this TLS requirement, students running macOS (35% in 2022) could simply start Redis on boot by running the following command once:

```
brew services start redis
```

Furthermore, removing TLS would further reduce the Redis configuration file complexity.
In fact, by removing TLS, there is no need for a config file at all.

_Note: A custom connector build resolved this issue. Within GOAL, it is now possible to set the `notls` environment value to disable SSL/TLS._

### Remove SIC/Redis

Similar to the work done on the `eis-ga-only` connector, a connector could be made which integrates the Dialogflow and Webserver services directly.
This would remove all dependencies from the project.

Similarly, one could only remove Redis/SIC from the picture.
The only remaining dependency would be Thunderstruck, which could replace Redis's Pub/Sub by offering a WebSocket-based API (or SSE + REST API combination).

There is no clear reason why one would choose Thunderstruck over a SIC-less connector, except for the fact that Thunderstruck is not written in Java.