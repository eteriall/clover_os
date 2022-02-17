FROM ghcr.io/copterexpress/clover-cloud:latest

RUN pip uninstall -y butterfly
RUN pip install git+https://github.com/eteriall/butterfly-redesign

RUN ["echo", "success!"]

RUN curl -fsSL https://code-server.dev/install.sh | sh
COPY code-server.service "/lib/systemd/system/"
COPY clover.launch "/home/pi/catkin_ws/src/clover/clover/launch/"

USER root
RUN systemctl daemon-reload
RUN systemctl enable code-server

CMD ["/usr/bin/systemctl"]
EXPOSE 8080 8081 9090 7070 57575 591


