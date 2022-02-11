FROM ghcr.io/copterexpress/clover-cloud:latest

RUN pip uninstall -y butterfly
RUN pip install git+https://github.com/eteriall/butterfly-redesign

RUN curl -fsSL https://code-server.dev/install.sh | sh

RUN ["echo", "success!"]

CMD ["/usr/bin/systemctl"]

# Visual Studio Code server service
COPY vs-code.service /lib/systemd/system/

RUN systemctl daemon-reload

USER pi

EXPOSE 8080 8081 9090 7070 57575 591

CMD code-server --auth none --host 0.0.0.0 --bind-addr localhost:591


