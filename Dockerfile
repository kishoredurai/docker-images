FROM kasmweb/core-ubuntu-focal:1.11.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

RUN apt update
RUN apt -y upgrade
RUN apt -y install openvpn

COPY assests/img.png /usr/share/extra/backgrounds/bg_default.png
# COPY assests/logo.png /usr/share/kasmvnc/www/dist/images/782e6b34fd46a00744786246a454ed11.png
COPY assests/Bannari_Amman_Institute_of_Technology_logo.png /usr/share/kasmvnc/www/app/images/icons/kasm_logo.png


RUN touch $HOME/Desktop/hello.txt

### Create user and home directory for base images that don't already define it
RUN (groupadd -g 1000 kishore \
    && useradd -M -u 1000 -g 1000 kishore -p kishore\
    && usermod -a -G kishore kishore) ; exit 0
ENV HOME /home/kishore
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kishore
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000