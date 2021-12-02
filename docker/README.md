Docker
======

- [Docker](#docker)
- [Dockerfile](#dockerfile)
    - [Dockerfile Instructions](#dockerfile-instructions)
      - [FROM](#from)
      - [RUN](#run)
      - [CMD](#cmd)
      - [LABEL](#label)
      - [EXPOSE](#expose)
      - [ENV](#env)
      - [ADD](#add)
      - [COPY](#copy)
      - [ENTRYPOINT](#entrypoint)
      - [VOLUME](#volume)
      - [USER](#user)
      - [WORKDIR](#workdir)
      - [ARG](#arg)
      - [ONBUILD](#onbuild)
      - [SHELL](#shell)
    - [Reference](#reference)

# Dockerfile
Docker can build images automatically by reading the instruction from a Dockerfile. A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image.
Dockerfile supports following lists of instruction
### Dockerfile Instructions

  - [FROM](#from)
  - [RUN](#run)
  - [CMD](#cmd)
  - [LABEL](#label)
  - [EXPOSE](#expose)
  - [ENV](#env)
  - [ADD](#add)
  - [COPY](#copy)
  - [ENTRYPOINT](#entrypoint)
  - [VOLUME](#volume)
  - [USER](#user)
  - [WORKDIR](#workdir)
  - [ARG](#arg)
  - [ONBUILD](#onbuild)
  - [SHELL](#shell)

#### FROM
The FROM instruction initializes a new build stage and sets the Base Image for subsequent instructions. As such, a valid Dockerfile must start with a FROM instruction.

```shell
FROM [--platform=<platform>] <image> [AS <name>]
FROM [--platform=<platform>] <image>[:<tag>] [AS <name>]
FROM [--platform=<platform>] <image>[@<digest>] [AS <name>]
```
```--platform``` flag can be used to specify the platform of the image in case FROM references a multi-platform image. For example, linux/amd64, linux/arm64, or windows/amd64. By default, the target platform of the build request is used.  
```<image>[:<tag>]``` option sets base image with tag for subsequent instruction.  

FROM instructions support variables that are declared by any ARG instructions that occur before the first FROM.
```shell
ARG  CODE_VERSION=latest
FROM base:${CODE_VERSION}
CMD  /code/run-app

FROM extras:${CODE_VERSION}
CMD  /code/run-extras

---

ARG VERSION=latest
FROM busybox:$VERSION
ARG VERSION
RUN echo $VERSION > image_version
```

#### RUN
The RUN instruction will execute any commands in a new layer on top of the current image and commit the results. The resulting committed image will be used for the next step in the Dockerfile.\

Layering RUN instructions and generating commits conforms to the core concepts of Docker where commits are cheap and containers can be created from any point in an image’s history, much like source control.\
**RUN has 2 forms:**  
- RUN <command> (shell form, the command is run in a shell, which by default is /bin/sh -c on Linux or cmd /S /C on Windows)
- RUN ["executable", "param1", "param2"] (exec form)

```shell
RUN /bin/bash -c 'source $HOME/.bashrc; \
echo $HOME'

or

RUN /bin/bash -c 'source $HOME/.bashrc; echo $HOME'

or

RUN ["/bin/bash", "-c", "echo hello"]
```

#### CMD
The CMD instruction has three forms:
- CMD ["executable","param1","param2"] (exec form, this is the preferred form)
- CMD ["param1","param2"] (as default parameters to ENTRYPOINT)
- CMD command param1 param2 (shell form)

__Note:__  
There can only be one CMD instruction in a Dockerfile. If you list more than one CMD then only the last CMD will take effect.  

#### LABEL
#### EXPOSE
#### ENV
#### ADD
#### COPY
The ```COPY``` instruction copies new files or directories from ```<src>``` and adds them to the filesystem of the container at the path ```<dest>```.

Multiple ```<src>``` resources may be specified but the paths of files and directories will be interpreted as relative to the source of the context of the build.

**COPY has two forms:**  

```shell
COPY [--chown=<user>:<group>] <src>... <dest>
COPY [--chown=<user>:<group>] ["<src>",... "<dest>"]
```

**Example**  
```shell
COPY --chown=55:mygroup files* /somedir/
COPY --chown=bin files* /somedir/
COPY --chown=1 files* /somedir/
COPY --chown=10:11 files* /somedir/
```

COPY obeys the following rules:
- The <src> path must be inside the context of the build; you cannot COPY ../something /something, because the first step of a docker build is to send the context directory (and subdirectories) to the docker daemon.
- If <src> is a directory, the entire contents of the directory are copied, including filesystem metadata.
  

  

#### ENTRYPOINT
#### VOLUME
#### USER
#### WORKDIR
#### ARG
#### ONBUILD
#### SHELL


### Reference
* https://docs.docker.com/engine/reference/builder/
