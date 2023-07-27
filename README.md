# Open eGov MessageHandler Docker

This repository is used to build the offical docker image for Open eGov MessageHandler. Further information 
regarding Open eGov MessageHandler consult the 
[MessageHandler Wiki](https://oewiki.atlassian.net/wiki/spaces/openegovdoc/pages/1015884/MessageHandler)

This Docker image should be used in conjunction with the
[offical sedex Docker image](https://hub.docker.com/r/sedexch/sedex-client).

## Build the image for development

To build the Docker imagage locally for development

docker build . --file Dockerfile --tag gluech/msghandler:dev

## Usage

The docker images are available on 
[Glue Software Engineering AG - MessageHandler Images](https://hub.docker.com/repository/docker/gluech/msghandler/)

To use the MessageHandler images from Docker hub, run

```
docker pull gluech/mh:1.0.1
```

## How to test drive MH?

To test drive the docker image, clone the 
[msghandler-docker](https://github.com/Glue-Software-Engineering-AG/msghandler-docker) repository on Github and

```
cd .../msghandler-docker
docker compose up -d
```

The MH container will start up. All files and directories it need are located underneath the directory `host-folders`.

| Directory | Description |
| --------- | ----------- |
| host-folders/conf | MH configuration relative to `host-folders` |
| host-folders/log | MH log files |
| host-folders/sedex/interface | sedex interface direcories |
| host-folders/mh/ech-0112 | sample inbox, outbox and receipts directories of transparent (aka sedex) application |
| host-folders/mh/eschkg | sample inbox, outbox and signing-outbox directories of native (aka eSchKG/eLP) application |
| host-folders/mh/working | Working directories of MH |

Use the configuration and directory structure underneath the directory `host-folders` as a model for your own
deployments.

## Docker hub tags


| Tag      | Description                                                  | Release date |
|----------|--------------------------------------------------------------|--------------|
| mh-1.0.0 | MessageHandler 3.4.2, Amazon Corretto JRE 8u372, Alpine 3.17 | 2023-06-01   |
| dev      | Development version. Do not use for production               | 2023-06-01   |

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

Due to dependencies in the MessageHandler code, we cannot update the vulnerable libraries to newer versions.
However, we have analysed the situation in detail and have concluded that the reported vulnerabilities in MessageHandler
will not affect the secure operation of MessageHandler in any way.