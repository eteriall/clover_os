# CloverOS

### CloverOS is a service providing software for drone programming.

## [http://alpha.coex-cloud.ru](http://alpha.coex-cloud.ru)

<img width="1680" alt="Screenshot 2022-02-16 at 20:02:55" src="https://user-images.githubusercontent.com/57683566/154317387-83aa605d-06ab-418b-98a7-dd4084815c7d.png">

The CloverOS module is part of the COEX-Cloud project — a cloud-based service for modeling behavior and programming quadcopters in a cloud environment.

* `http://<ip_address>:8000` — Blockly
* `http://<ip_address>:591` — Visual Studio Code
* `http://<ip_address>:8080` — Clover web tools
* `http://<ip_address>:57575` — Terminal
* `http://<ip_address>:7070` — Gazebo web

<img src="https://user-images.githubusercontent.com/57683566/154319227-1a41ed9e-b7d9-484f-82ed-3586fbb76b19.png" width="600px">

At any given time, three systemd services are running on the virtual machine:

* **CLOVER-CLOUD-APP** — CloverOS. Port 80.
* **CLOVER-CLOUD** — Docker container with ROS, Gazebo, and an internal code-server for editing flight program code. Exposed ports: 7070, 57575, 8080, 591, 8000.
* **CODE-SERVER** — External VS Code for testing new features and modifying the source code of all services. Access can be granted to any tester, but after the service release, access will be restricted. This service also provides root-level access to the VM console. Port 5000.
