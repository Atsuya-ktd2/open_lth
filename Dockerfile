# [1] base setting
# FROM nvidia/cuda:11.0.3-cudnn8-runtime-ubuntu18.04
# FROM nvidia/cuda:11.1.1-cudnn8-runtime-ubuntu16.04
FROM nvidia/cuda:11.4.1-cudnn8-runtime-ubuntu20.04
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME /root
# 追加
ENV TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0 8.6+PTX"

# [2] zsh
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y \
    wget \
    curl \ 
    git \
    vim-athena \ 
    zsh \
    unzip --no-install-recommends

SHELL ["/bin/zsh", "-c"]
RUN wget http://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

# [3] pyenv

RUN apt-get update && \
    apt-get install -y \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    python-openssl --no-install-recommends

RUN curl https://pyenv.run | zsh && \
    echo '' >> $HOME/.zshrc && \
    echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> $HOME/.zshrc && \
    echo 'eval "$(pyenv init -)"' >> $HOME/.zshrc && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> $HOME/.zshrc

ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN pyenv install 3.7.4 && \
    pyenv global 3.7.4 && \
    pyenv rehash


CMD ["/bin/zsh"]


