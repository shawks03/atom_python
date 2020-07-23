FROM ubuntu:20.04

ENV ATOM_VERSION v1.49.0

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies for atom
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      gconf2 \
      dconf-editor \
      dbus-x11 \
      git \
      gvfs-bin \
      libasound2 \
      libgtk-3-0 \
      libnotify4 \
      libnss3 \
      libx11-xcb1 \
      libxkbfile1 \
      libxss1 \
      libxtst6 \
      policykit-1 \
      python \
      xdg-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Make python3 the default version
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python2 2 && \
    update-alternatives --set python /usr/bin/python3

# Install atom
RUN curl -L https://github.com/atom/atom/releases/download/${ATOM_VERSION}/atom-amd64.deb > /tmp/atom-amd64.deb && \
    dpkg -i /tmp/atom-amd64.deb && \
    rm -f /tmp/atom-amd64.deb && \
    useradd -d /home/atom -m atom -s /bin/bash

# Turn atom into a python IDE
# https://hackernoon.com/setting-up-atom-as-a-python-ide-a-how-to-guide-o6dd37ff
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3-pip && \
    apt-get remove -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apm install linter linter-ui-default intentions busy-signal && \
    pip3 install flake8 && \
    apm install linter-flake8 && \
    apm install autocomplete-python && \
    pip3 install autopep8 && \
    apm install python-autopep8 && \
    apm install script && \
    apm install atom-file-icons && \
    apm install atom-material-syntax && \
    apm install minimap && \
    apm install minimap-git-diff && \
    apm install minimap-highlight-selected && \
    pip3 install pytest && \
    apm install atom-python-test

USER atom

CMD ["/usr/bin/atom","-f","--no-sandbox"]
