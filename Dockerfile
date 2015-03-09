FROM joelpet/debian:jessie

ADD Mnemosyne-2.3.2.tar.gz /src
WORKDIR /src/Mnemosyne-2.3.2

RUN (\
    export DEBIAN_FRONTEND=noninteractive; \
    sed --in-place 's/ftp.us.debian.org/ftp.se.debian.org/' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        libqt4-sql-sqlite \
        pyqt4-dev-tools \
        python-cherrypy3 \
        python-matplotlib \
        python-qt4-dev \
        python-qt4-phonon \
        python-qt4-sql \
        python-setuptools \
        python-sphinx \
        python-virtualenv \
        python-webob \
        qt4-designer \
        sqlite3 \
        && \
    rm -rf /var/lib/apt/lists/*debian.{org,net}* && \
    apt-get purge -y --auto-remove && \
    useradd --system --create-home --home /home/mnemosyne mnemosyne && \
    echo 'mnemosyne ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    python setup.py install \
    )

#USER mnemosyne
ENV HOME /home/mnemosyne
WORKDIR /home/mnemosyne

COPY configdb_dump.sql /tmp/
RUN \
    mkdir -p /home/mnemosyne/.config/mnemosyne && \
    sqlite3 /home/mnemosyne/.config/mnemosyne/config.db < /tmp/configdb_dump.sql

#VOLUME /home/mnemosyne/.local/share/mnemosyne

EXPOSE 8512
EXPOSE 8513

ENTRYPOINT ["mnemosyne", "--sync-server", "--web-server"]
