FROM ubuntu:20.04
RUN apt update && apt upgrade
RUN apt install -y zsh curl git
RUN zsh
COPY . /app/
RUN /app/install.sh