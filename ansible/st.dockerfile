FROM ubuntu

RUN apt update && apt install -y --no-install-recommends \
    git \
    automake \
    ca-certificates \
    gcc \
    libx11-dev \
    libxft-dev

RUN git clone --depth=1 -b 0.8.2  https://git.suckless.org/st && \
    cd st && make && \
    chmod 777 st && chown 1000:100 st

WORKDIR /st

ENTRYPOINT ["mv", "st", "/app"]
