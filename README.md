# atom_python

## Overview

Atom as a Python IDE inside a Docker container

## Building the image

Clone this repository, change into the source directory and run:

```
docker build . -t shawks03/atom_python
```
## Running Atom

```
docker run --rm \
  -v atom:/home/atom/.atom \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /dev/shm:/dev/shm \
  -e DISPLAY=$DISPLAY \
  shawks03/atom_python
```
Note that `-v /dev/shm:/dev/shm` may be optional and can be replaced by `--shm-size="<number><unit>"`.


