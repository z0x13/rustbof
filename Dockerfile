FROM rust:latest

RUN apt-get update && apt-get install -y \
    mingw-w64 \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN cargo install cargo-make

RUN git clone https://github.com/MEhrn00/boflink.git /tmp/boflink \
    && cd /tmp/boflink \
    && cargo xtask install \
    && rm -rf /tmp/boflink

WORKDIR /app

COPY . .

RUN cd examples/env && cargo make \
    && cd ../ipconfig && cargo make \
    && cd ../whoami && cargo make

CMD ["bash"]
