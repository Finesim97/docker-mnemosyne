FROM debian:jessie

RUN (\
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get update && \
    apt-get install -y \
        mnemosyne \
        && \
    rm -r /var/lib/apt/lists/* \
    )

ENTRYPOINT ["mnemosyne"]
