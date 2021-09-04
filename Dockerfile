FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex; \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        ubuntu-desktop \
        unity-lens-applications \
        gnome-panel \
        metacity \
        nautilus \
        gedit \
        xterm \
        sudo \
	    firefox \
	    midori \
        bash \
        net-tools \
        novnc \
        socat \
        x11vnc \
        gnome-panel \
        gnome-terminal \
        xvfb \
        supervisor \
        net-tools \
        curl \
        git \
	python3.6 \
	    wget \
        libtasn1-3-bin \
        libglu1-mesa \
        libqt5webkit5 \
        libqt5x11extras5 \
        qml-module-qtquick-controls \
        qml-module-qtquick-dialogs \
        g++ \
        ssh \
        terminator \
        htop \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1366 \
    DISPLAY_HEIGHT=668 \
    RUN_XTERM=yes \
    RUN_UNITY=yes

RUN adduser ubuntu

RUN echo "ubuntu:ubuntu" | chpasswd && \
    adduser ubuntu sudo && \
    sudo usermod -a -G sudo ubuntu

RUN sudo add-apt-repository ppa:obsproject/obs-studio \
     && sudo apt-get update && sudo apt-get install -y obs-studio

RUN curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

COPY . /app

RUN chmod +x /app/conf.d/websockify.sh
RUN chmod +x /app/run.sh
USER ubuntu

CMD ["/app/run.sh"]
