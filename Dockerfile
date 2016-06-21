FROM debian:jessie

ENV HOME /home/mnemosyne

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
        texlive-base \
        dvipng \
        && \
    rm -rf /var/lib/apt/lists/*debian.{org,net}* && \
    apt-get purge -y --auto-remove && \
    useradd --system --create-home --home /home/mnemosyne mnemosyne && \
    echo 'mnemosyne ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    )


ADD Mnemosyne-2.3.6.tar.gz /src
WORKDIR /src/Mnemosyne-2.3.6

RUN python setup.py install 

WORKDIR /home/mnemosyne
USER mnemosyne

#COPY configdb_dump.sql /tmp/
#RUN \
#    mkdir -p /home/mnemosyne/.config/mnemosyne && \
#    sqlite3 /home/mnemosyne/.config/mnemosyne/config.db < /tmp/configdb_dump.sql

#VOLUME /home/mnemosyne/.local/share/mnemosyne

EXPOSE 8512
EXPOSE 8513

ENTRYPOINT ["mnemosyne"]
