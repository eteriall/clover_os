FROM ros:noetic-ros-base-focal

# Install basic utilies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y xorg openbox xvfb
RUN apt-get install -y python3-rosdep python3-rosinstall-generator python3-wstool build-essential git python3-pip apt-utils
RUN apt-get install -y ca-certificates gnupg lsb-core sudo wget curl

# Add user pi with password raspberry, make it a sudoer
RUN useradd -m -p saRblwUvaZylg pi
RUN echo 'pi ALL = NOPASSWD : ALL' >> /etc/sudoers
USER pi
WORKDIR /home/pi

# Build PX4
RUN git clone --recursive --depth 1 --branch v1.12.0 https://github.com/PX4/PX4-Autopilot.git ${HOME}/PX4-Autopilot
RUN $HOME/PX4-Autopilot/Tools/setup/ubuntu.sh --no-nuttx
RUN make -C $HOME/PX4-Autopilot px4_sitl

# Build and install Clover
COPY install_clover /
RUN /install_clover

# Install gzweb
COPY install_gzweb /
RUN /install_gzweb

# Install additional packages
USER root
RUN apt-get install -y sshfs gvfs-fuse gvfs-backends python3-opencv \
	byobu ipython3 byobu nmap lsof tmux vim nano ros-noetic-rqt-multiplot htop expect

# Clean up
RUN apt-get -y autoremove && apt-get -y autoclean && apt-get -y clean

# Install Butterfly
RUN pip uninstall -y butterly
RUN pip install git+https://eteriall/butterfly_redesign

# Remove unneeded services
RUN rm -rf /etc/systemd/* /lib/systemd/* /var/lib/systemd/* /etc/init.d/*
COPY assets/*.service /lib/systemd/system/

# Install Monkey
RUN wget https://github.com/CopterExpress/clover_vm/raw/master/assets/packages/monkey_1.6.9-1_amd64.deb
RUN apt-get install -y ./monkey_1.6.9-1_amd64.deb
RUN rm monkey_1.6.9-1_amd64.deb
RUN cp /home/pi/catkin_ws/src/clover/builder/assets/monkey /etc/monkey/sites/default
RUN cp /home/pi/catkin_ws/src/clover/builder/assets/monkey.service /lib/systemd/system/monkey.service

# Install fake systemd
RUN wget https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py -O /usr/bin/systemctl
RUN wget https://github.com/gdraheim/docker-systemctl-replacement/raw/master/files/docker/journalctl3.py -O /usr/bin/journalctl
RUN chmod +x /usr/bin/systemctl /usr/bin/journalctl
RUN systemctl enable xvfb
RUN systemctl enable roscore
RUN systemctl enable clover
RUN systemctl enable butterfly
RUN systemctl enable monkey

# Copy main launch-file
COPY assets/cloud.launch /

CMD ["/usr/bin/systemctl"]

EXPOSE 8080 8081 9090 7070 57575
