# Debian with C/C++ environment and butterfly
FROM       debian:latest
MAINTAINER Zhang Maiyun "https://github.com/myzhang1029"

RUN echo "deb http://mirrors.ustc.edu.cn/debian stretch main contrib non-free" > /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y build-essential cmake zsh wget git vim sudo libreadline-dev python-setuptools python-dev python-pip libncurses-dev libffi-dev libssl-dev ssh-client && apt-get clean && rm -rf /var/lib/apt/lists/*

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
RUN pip install butterfly
RUN pip install libsass
COPY ["butterfly.conf", "/etc/butterfly/butterfly.conf"]
EXPOSE 2233

CMD  ["butterfly.server.py"]
