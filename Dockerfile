# Debian with C/C++ environment and butterfly
FROM       debian:latest
LABEL maintainer="Zhang Maiyun <myzhang1029@hotmail.com>"

# Set up APT
RUN sed -i 's/httpredir.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# Install packages
RUN apt-get install -y build-essential cmake zsh wget git vim sudo libreadline-dev python-setuptools python-dev python-pip libncurses-dev libffi-dev libssl-dev ssh-client

# Housekeeping
RUN apt-get clean
RUN apt-get autoremove --purge -y
RUN rm -rf /var/lib/apt/lists/*

# Add user deb
RUN mkdir /home/deb
RUN useradd deb -s /usr/bin/zsh -d /home/deb
RUN chown deb:deb /home/deb
RUN echo 'deb:debian' | chpasswd
RUN echo 'deb	ALL = (ALL:ALL) ALL' >/etc/sudoers.d/deb

# Install oh-my-zsh
RUN sudo -EHudeb sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Install butterfly terminal
RUN echo 'root:root' | chpasswd
RUN pip install butterfly libsass
COPY ["butterfly.conf", "/etc/butterfly/butterfly.conf"]
EXPOSE 2233

CMD  ["butterfly.server.py"]
