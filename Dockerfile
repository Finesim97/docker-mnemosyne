FROM debian:buster-slim

ENV HOME /home/mnemosyne

RUN (\
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        pyqt5-dev-tools \
        python3-pyqt5.qtwebengine \
        python3-cherrypy3 \
        python3-cheroot \
        python3-matplotlib \
        pyqt5-dev \
        python3-setuptools \
        python3-sphinx \
        python3-virtualenv \
        python3-webob \
        sqlite3 \
        python3-pip \
        texlive-latex-base \
        dvipng \
        curl \
        && \
    rm -rf /var/lib/apt/lists/*debian.{org,net}* && \
    apt-get purge -y --auto-remove && \
    useradd -u 1000 --system --create-home --home /home/mnemosyne mnemosyne \
    )
    
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir googletrans

ENV MNEM_VERSION 2.7.1

RUN mkdir -p /src && \
    curl -L https://sourceforge.net/projects/mnemosyne-proj/files/mnemosyne/mnemosyne-${MNEM_VERSION}/Mnemosyne-${MNEM_VERSION}.tar.gz/download | \
    tar xzf - -C /src
WORKDIR /src/Mnemosyne-${MNEM_VERSION}

RUN python3 setup.py install 

WORKDIR /home/mnemosyne
COPY entrypoint.sh /usr/local/bin/
USER mnemosyne
COPY configdb_dump.sql /tmp/
RUN \
    mkdir -p /home/mnemosyne/.config/mnemosyne && \
    sqlite3 /home/mnemosyne/.config/mnemosyne/config.db < /tmp/configdb_dump.sql

VOLUME /home/mnemosyne/.local/share/mnemosyne/
#VOLUME /home/mnemosyne/.config/mnemosyne/

USER root
EXPOSE 8512
EXPOSE 8513
ENTRYPOINT ["entrypoint.sh"]
CMD ["mnemosyne"]
