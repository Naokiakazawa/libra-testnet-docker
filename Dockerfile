FROM ubuntu:19.04
#sh can't execute source command 
SHELL ["/bin/bash", "-c"]
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install \
        cmake \
        curl \
        git \
        golang \
        libssl-dev \
        protobuf-compiler \
        sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/libra/libra.git
WORKDIR /libra
RUN yes | ./scripts/dev_setup.sh \
    && source /root/.cargo/env \
    && cargo build
CMD [ "./scripts/cli/start_cli_testnet.sh" ]