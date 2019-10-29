FROM debian:buster-slim

ENV HOME /home/mnemosyne

RUN (\
    export DEBIAN_FRONTEND=noninteractive; \
    apt update && \
    apt install -y --no-install-recommends \
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
        texlive-latex-base \
        dvipng \
        && \
    rm -rf /var/lib/apt/lists/*debian.{org,net}* && \
    apt-get purge -y --auto-remove && \
    useradd --system --create-home --home /home/mnemosyne mnemosyne \
    )

ENV MNEM_VERSION 2.6.1

ADD https://sourceforge.net/projects/mnemosyne-proj/files/mnemosyne/mnemosyne-${MNEM_VERSION}/Mnemosyne-${MNEM_VERSION}.tar.gz/download /src
WORKDIR /src/Mnemosyne-${MNEM_VERSION}

RUN python setup.py install 

WORKDIR /home/mnemosyne
COPY entrypoint.sh /usr/local/bin/
USER mnemosyne

COPY configdb_dump.sql /tmp/
RUN \
    mkdir -p /home/mnemosyne/.config/mnemosyne && \
    sqlite3 /home/mnemosyne/.config/mnemosyne/config.db < /tmp/configdb_dump.sql

VOLUME /home/mnemosyne/.config/mnemosyne

EXPOSE 8512
EXPOSE 8513

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mnemosyne"]
