FROM ubuntu:16.04
RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list.d/multiverse.list
RUN apt-get update && apt-get install -y make unrar autoconf automake libtool libtool gcc g++ gperf flex bison texinfo gawk ncurses-dev libexpat1-dev python sed python-serial srecord bc git wget bzip2 unzip libtool-bin help2man python-dev
RUN useradd frickler 
RUN chown frickler:frickler /opt/
RUN su -c "bash -c 'cd /opt/ && git clone --recursive https://github.com/pfalcon/esp-open-sdk.git'" frickler
RUN cd /opt/esp-open-sdk && su -c "make STANDALONE=y" frickler
RUN mkdir /home/frickler && chown frickler:frickler /home/frickler

COPY bashrc /home/frickler/.bashrc
RUN chown frickler:frickler /home/frickler/.bashrc

RUN cd /home/frickler && su -c "bash -c 'git clone https://github.com/SmingHub/Sming.git'" frickler
RUN cd /home/frickler/Sming/Sming && su -c 'bash -c make frickler'
RUN cd /home/frickler/Sming/Sming && su -c 'bash -c "make spiffy" frickler'

RUN cd /opt/esp-open-sdk/ && su -c "bash -c 'git clone https://github.com/raburton/esptool2' frickler" 
RUN cd /opt/esp-open-sdk/esptool2/ && su -c "bash -c make frickler" 

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

ADD entry.sh /
CMD /entry.sh
