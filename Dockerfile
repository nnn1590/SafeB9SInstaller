FROM ubuntu:20.04

# Install dependencies
RUN apt-get update -y
RUN apt-get install -y wget git python3-pip
RUN pip3 install -U git+https://github.com/TuxSH/firmtool.git

# Install devkitPro
RUN wget https://apt.devkitpro.org/install-devkitpro-pacman
RUN chmod +x install-devkitpro-pacman
RUN yes | DEBIAN_FRONTEND=noninteractive ./install-devkitpro-pacman
RUN dkp-pacman -Syy --noconfirm
RUN dkp-pacman -S 3ds-dev --noconfirm

# Build SafeB9SInstaller
RUN git clone https://github.com/d0k3/SafeB9SInstaller.git --recursive
WORKDIR SafeB9SInstaller
RUN . /etc/profile.d/devkit-env.sh && make
