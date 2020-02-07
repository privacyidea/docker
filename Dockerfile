FROM python:3.7

ENV DEBIAN_FRONTEND="noninteractive"
ENV USER=pi
ENV HOME=/home/pi
ENV PRIVACYIDEA_CONFIGFILE=$HOME/pi.py
ENV PATH=$PATH:/home/pi/.local/bin

RUN useradd -ms /bin/bash $USER -u 1000 \
    && mkdir -p $HOME/db \
    && chown "${USER}:${USER}" ${HOME}/db

RUN apt-get update -yqq \
    && apt-get install -yqq \
        unixodbc-dev \
    && rm -rf /var/lib/apt/list/*

USER $USER

WORKDIR $HOME

RUN pip -q install virtualenv \
    && virtualenv /home/pi \
    && . bin/activate \
    && pip -q install privacyidea==3.2.2 pymssql==2.1.4 \
    && pip -q install -r lib/privacyidea/requirements.txt \
    && rm -rf ~/.cache/pip

COPY --chown=1000:1000 . .

ENTRYPOINT [ "./entrypoint.sh" ]

CMD ["./start-server.sh"]

EXPOSE 5000