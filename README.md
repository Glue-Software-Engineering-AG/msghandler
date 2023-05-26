# Open eGov MessageHandler Docker

This repository is used to build the offical docker image for Open eGov MessageHandler.

## Usage

The docker images are available on 
[Glue Software Engineering AG - MessageHandler Images](https://hub.docker.com/repository/docker/gluech/msghandler-docker/)

To use the MessageHandler images from Docker hub, run

```
docker pull gluech/msghandler
```

## Docker hub tags


| Tag     | Description                                                  | Release date |
|---------|--------------------------------------------------------------| ----------- |
| mh-1.0.0 | MessageHandler 3.4.2, Amazon Corretto JRE 8u372, Alpine 3.17 | 2023-05-26 |

## Why does the tag latest not exist?

In the Docker world, the special tag latest usually points to the latest image for a container. It can be dangerous
to use this tag, as it references different versions of the container over time that may not be compatible.
Using the latest tag can lead to unpredictable behaviour. For this reason, we avoid using the latest tag. For more
about the different versions and tags of the Docker image, see above.

## Known Vulnerabilities

As of Mai 2023 the vulnerability check of Docker Hub reports vulnerabilities in the following Java libraries used by 
MessageHandler 3.4.2:

* org.apache.santuario/xmlsec 2.0.7
* commons-beanutils/commons-beanutils 1.8.3
* commons-io/commons-io 2.6
* com.google.guava/guava 23.6-android

Due to given dependencies in the code of MessageHandler, we cannot lift the vulnerable libraries to newer versions. 
However, we have analysed the situation in detail and have come to the conclusion that the reported vulnerabilities 
cannot be exploited in MessageHandler.