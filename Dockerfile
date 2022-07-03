FROM ubuntu:20.04
LABEL maintainer="Nic Newdigate <nicnewdigate@gmail.com>"
LABEL Description="Image for building arm-embedded projects using cmake"
WORKDIR /work

ADD . /work

# Install any needed packages specified in requirements.txt
RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
# Development files
      cmake \
      build-essential \
      git \
      bzip2 \
      wget && \
    apt-get clean
RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 | tar -xj

RUN git clone https://github.com/newdigate/teensy-cmake-macros.git && \
    cd teensy-cmake-macros && \
    mkdir cmake-build && cd cmake-build && cmake .. && make install
ENV PATH "/work/gcc-arm-none-eabi-10.3-2021.10/bin:$PATH"