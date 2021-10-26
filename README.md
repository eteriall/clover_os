# 🍀☁️

Clover drone simulation playground for cloud.

## Running

Prerequisites: [Docker](https://docs.docker.com/engine/install/ubuntu/).

```bash
docker run -p 8080:8080 -p 9090:9090 -p 7070:7070 -p 57575:57575 -p 8000:80 -p 18570:18570/udp \
  ghcr.io/copterexpress/clover-cloud:latest
```

Note that downloading the image may take a while as it's quite large currently.

Access the drone using web tools:

* `<ip_address>:8080` – Clover's web tools. Use external camera view to monitor your simulation.
* `<ip_address>:57575` – Butterfly terminal.
* `<ip_address>:7070` – gzweb.

## Running managed simulation playground

Prerequisites: Ubuntu Linux (20.04+ is recommended), git, Python 3, pip.

Clone the repo:

```bash
git clone https://github.com/CopterExpress/clover_cloud.git
cd clover_cloud
```

Install Python dependencies (for `root` user):

```bash
sudo pip3 install -r requirements.txt
```

Make an environment file for systemd service:

```bash
echo "CLOVER_CLOUD_DIR=$(pwd)" | sudo tee -a /etc/systemd/system/clover-cloud-app.env
```

Install and run systemd services:

```bash
sudo ln -s $(realpath *.service) /lib/systemd/system
sudo systemctl enable clover-cloud-app
sudo systemctl start clover-cloud-app
```

Access managing app using `http://<ip_address>`.
