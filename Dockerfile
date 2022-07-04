FROM node:latest
LABEL maintainer="Nic Newdigate <nicnewdigate@gmail.com>"
LABEL Description="Image for building arm-embedded projects using cmake"

ENV DEBIAN_FRONTEND=noninteractive
RUN mkdir -p /home/runner/work
# Install any needed packages specified in requirements.txt
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
# Development files
      cmake \
      build-essential \
      git \
      bzip2 \
      wget && \
    apt-get clean
RUN cd /home/runner/work/ && \ 
    wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 | tar -xj   

RUN cd /home/runner/work/ && \
    git clone https://github.com/newdigate/teensy-cmake-macros.git && \
    cd teensy-cmake-macros && \
    mkdir cmake-build && cd cmake-build && cmake .. && make install
ENV PATH "/home/runner/work/gcc-arm-none-eabi-10.3-2021.10/bin:$PATH"
