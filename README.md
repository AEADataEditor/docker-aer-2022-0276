# Docker image basic Stata image with Julia

## Purpose

This Docker image is meant to isolate and stabilize that environment, and should be portable across
multiple operating system, as long as [Docker](https://docker.com) is available.

> To learn more about the use of containers for research reproducibility, see [Carpentries' docker-introduction](https://carpentries-incubator.github.io/docker-introduction/index.html). For commercial services running containers, see [codeocean.com](https://codeocean.com), [gigantum](https://gigantum.com/), or any of the cloud service providers. For an academic project using containers, see [Whole Tale](https://wholetale.org/).

> NOTE: The image created by these instructions contains binary code that is &copy; Stata. Permission was granted by Stata to Lars Vilhuber to post these images, without the license. A valid license is necessary to build and use these images. 

## Requirements

You need a Stata license to run the image. If rebuilding, may need Stata license to build the image.

### Where should you put the Stata license

In the documentation below, we will use a (bash) environment variable to abstract from the actual location of the Stata license. This has been tested on MacOS and Linux, and it *should* work using Git Bash on Windows. Comments welcome.

## Dockerfile

The [Dockerfile](Dockerfile) contains the build instructions. See <https://github.com/AEADataEditor/docker-stata> for more information on the base image used here.

Edit `.myconfig.sh` before building the image. Then use

```bash
./build.sh
```

to build the image.


## Using the image

For all the subsequent `docker run` commands, we will use similar environment variables:

```
VERSION=18
TAG=latest
MYHUBID=aeadataeditor
MYIMG=aer-2022-0276
```

and either

``` 
STATALIC="$(pwd)/stata.lic.${VERSION}"
```

or

```
STATALIC="$(find $HOME/Dropbox/ -name stata.lic.$VERSION | tail -1)"
```

where again, the various forms of `STATALIC` are meant to capture the location of the `stata.lic` file (in my case, it is called `stata.lic.18`, but in your case, it might be simply `stata.lic`). 

### Convenience script

Assuming these scripts are in the root directory of the replication package, the following will work provide a shell inside the container:

```bash
./run_docker.sh
```
