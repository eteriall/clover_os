# 🍀☁️

Clover drone simulation playground for cloud.

## Running

```bash
sudo docker run \
  -p 8080:8080 \
  -p 9090:9090 \
  -p 7070:7070 \
  -p 57575:57575 \
  -p 8000:80 \
  -p 18570:18570/udp \
  -p 591:591 \
  ghcr.io/eteriall/clover_os:latest
```
## Web-tools

* `http://<ip_address>:8080` – Clover's web tools.
* `http://<ip_address>:57575` – Terminal.
* `http://<ip_address>:7070` – Gazebo web.
* `http://<ip_address>:591` – Visual Studio code.

## Running managed simulation playground

```bash
git clone https://github.com/eteriall/clover_cloud
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
