# Debian with C/C++ environment and butterfly
FROM       debian:latest
MAINTAINER Zhang Maiyun "https://github.com/myzhang1029"

RUN echo "deb http://mirrors.163.com/debian stretch main contrib non-free" > /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y build-essential wget git vim sudo libreadline-dev zsh python-setuptools python-dev python-pip libffi-dev libssl-dev ssh-client && apt-get clean && rm -rf /var/lib/apt/lists/*

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
RUN pip install butterfly && pip install libsass

EXPOSE 2233

CMD  ["butterfly.server.py", "--port=2233", "--unsecure", "--host=0.0.0.0"]
