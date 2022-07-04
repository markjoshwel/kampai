FROM gitpod/workspace-full

USER gitpod
ENV PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH
RUN curl -fsSL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash \
    && { echo; \
        echo 'eval "$(pyenv init -)"'; \
        echo 'eval "$(pyenv virtualenv-init -)"'; } >> /home/gitpod/.bashrc.d/60-python \
    && pyenv update \
    && pyenv install 3.10.5 \
    && pyenv global 3.10.5 \
    && python3 -m pip install --no-cache-dir --upgrade pip \
    && python3 -m pip install --no-cache-dir --upgrade \
        setuptools wheel virtualenv \
    && sudo rm -rf /tmp/*
ENV PIP_USER=no
ENV PIPENV_VENV_IN_PROJECT=true
ENV PYTHONUSERBASE=/workspace/.pip-modules
ENV PATH=$PYTHONUSERBASE/bin:$PATH
RUN python3 -m pip install --no-cache-dir --upgrade poetry==1.2.0b2
RUN python3 -m poetry config virtualenvs.in-project true
