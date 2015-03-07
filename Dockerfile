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
        && \
    rm -rf /var/lib/apt/lists/*debian.{org,net}* && \
    apt-get purge -y --auto-remove && \
    python setup.py install \
    )

EXPOSE 8512
EXPOSE 8513

ENTRYPOINT ["mnemosyne", "--sync-server", "--web-server"]
