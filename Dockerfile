FROM ubuntu:20.04

ARG USERNAME=basd4g

RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list

RUN apt-get update \
   && apt-get dist-upgrade -y \
   && apt-get install -y sudo git make gnupg2 \
   && rm -rf /var/lib/apt/lists/*

# For jp_JP.UTF-8 and JST(Asia/Tokyo)
ENV DEBIAN_FRONTEND noninteractive
ENV TZ Japan
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:en
ENV LC_ALL ja_JP.UTF-8
RUN apt-get update \
  && apt-get install -y apt-utils tzdata locales locales-all language-pack-ja-base language-pack-ja \
  && rm -rf /var/lib/apt/lists/* \
  && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && locale-gen ja_JP.UTF-8 \
  && sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen \
  && localedef -f UTF-8 -i ja_JP ja_JP.utf8

# adduser ${USERNAME}:${USERNAME} with password '${USERNAME}'
RUN groupadd -g 1000 ${USERNAME} \
   && useradd -g ${USERNAME} -G sudo -m -s /bin/bash ${USERNAME} \
   && echo "${USERNAME}:${USERNAME}" | chpasswd

RUN echo "Defaults visiblepw" >> /etc/sudoers
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ADD . /home/${USERNAME}/dotfiles
RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/dotfiles \
  && echo "sudo bash /home/${USERNAME}/dotfiles/setup.sh" | sudo -u ${USERNAME} -i sh - 2>&1 | tee /home/${USERNAME}/make.log

CMD ["bash"]
