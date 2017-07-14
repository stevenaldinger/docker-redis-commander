# Redis Commander (Redis GUI)

This project dockerizes [redis-commander](https://github.com/joeferner/redis-commander) in a minimal Alpine image based on [mhart/alpine-node](https://hub.docker.com/r/mhart/alpine-node/).

## Usage

Hosts can be optionally specified with a comma separated string by setting the `REDIS_HOSTS` environment variable.

After running the container, `redis-commander` will be available at [localhost:8081](http://localhost:8081).

### Valid host strings

Form should follow one of these templates:

`hostname`

`label:hostname`

`label:hostname:port`

`label:hostname:port:dbIndex`

`label:hostname:port:dbIndex:password`

### Simple

If you're running redis on `localhost:6379`, this is all you need to get started.

```
docker run --rm --name redis-commander -d \
  -p 8081:8081 \
  stevenaldinger/redis-commander:latest
```

### Specify single host

```
docker run --rm --name redis-commander -d \
  --env REDIS_HOSTS=10.10.20.30 \
  -p 8081:8081 \
  stevenaldinger/redis-commander:latest
```

### Specify multiple hosts with labels

```
docker run --rm --name redis-commander -d \
  --env REDIS_HOSTS=local:localhost:6379,myredis:10.10.20.30 \
  -p 8081:8081 \
  stevenaldinger/redis-commander:latest
```

## Cleanup

When you're done using the container, run `docker kill redis-commander` to kill and remove it.

## Build

First source the helpers script with `. ./helpers.sh` and then run `build-redis-commander`.

## Push

First source the helpers script with `. ./helpers.sh` and then run `push-redis-commander`.
