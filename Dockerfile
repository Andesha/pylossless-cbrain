# Install the base requirements for the app.
# This stage is to support development.
FROM ubuntu:latest
WORKDIR /pylossless

VOLUME ["/input", "/output"]

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y build-essential nano python3.10 python3-pip git

RUN git clone https://github.com/Andesha/pylossless.git

RUN pip install --editable ./pylossless
