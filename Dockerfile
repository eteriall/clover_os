FROM ghcr.io/copterexpress/clover-cloud:latest

RUN pip uninstall -y butterfly
RUN pip install git+https://github.com/eteriall/butterfly-redesign

RUN curl -fsSL https://code-server.dev/install.sh | sh

RUN ["echo", "success!"]

CMD ["/usr/bin/systemctl"]

# Visual Studio Code server service
COPY vs-code.service /lib/systemd/system/

RUN systemctl daemon-reload

RUN systemctl start vs-code
RUN systemctl enable vs-code

EXPOSE 8080 8081 9090 7070 57575 591
