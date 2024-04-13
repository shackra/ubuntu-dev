FROM ubuntu:22.04
MAINTAINER Jorge Araya Navarro <jorge@esavara.cr>

RUN apt update -yq && DEBIAN_FRONTEND=noninteractive apt upgrade -yq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    build-essential \
    pkg-config \
    autoconf-archive \
    ccache \
    gdb \
    lcov \
    libb2-dev \
    libbz2-dev \
    libffi-dev \
    libgdbm-dev \
    libgdbm-compat-dev \
    liblzma-dev \
    libncurses5-dev \
    libreadline6-dev \
    libsqlite3-dev \
    libssl-dev \
    lzma \
    lzma-dev \
    tk-dev \
    uuid-dev \
    zlib1g-dev \
    curl \
    git \
    zsh \
    pipx \
    sudo && apt-get clean

RUN useradd --create-home --shell /bin/zsh jorge

USER jorge
WORKDIR /home/jorge
COPY zshrc .zshrc

ENV PYENV_ROOT="/home/jorge/.pyenv"
ENV PATH="/home/jorge/.local/bin:$PYENV_ROOT/bin:$PATH"

RUN curl https://pyenv.run | bash && \
    pyenv install 3.12.2 && \
    pyenv global 3.12.2 && \
    eval "$(pyenv init -)" && \
    eval "$(pyenv virtualenv-init -)" && \
    pipx ensurepath && \
    pipx install poetry

CMD /bin/zsh
