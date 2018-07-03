FROM rocker/tidyverse
MAINTAINER DavidSichau <sichau@inf.ethz.ch>


RUN locale-gen en_US.UTF-8
ENV LANG="en_US.UTF-8"  \
    LANGUAGE="en_US:en"  \
    LC_ALL="en_US.UTF-8" \
    RSTUDIO_PANDOC=/usr/lib/rstudio/bin/pandoc


RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install \
     apt-utils \
     nginx && \
  mkdir /usr/share/nginx/html/latest && \
  rm /usr/share/nginx/html/index.html && \
  rm /etc/nginx/sites-enabled/default


RUN \
  DEBIAN_FRONTEND=noninteractive apt-get -y install \
    texlive-lang-german \
    texlive-fonts-extra \
    cm-super \
    fontconfig
RUN \
  R -e "devtools::install_github('Educational-Engineering/rticles')"

CMD ["nginx"]

EXPOSE 80
