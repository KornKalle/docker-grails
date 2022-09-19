FROM ubuntu:22.04 as build

ENV TZ=Europe/Berlin
ENV GRAILS_VERSION=5.2.4
ENV JAVA_VERSION=17.0.4.1-librca
WORKDIR /build

COPY ./ .

# Install dependencies
RUN apt-get update && apt-get install -y bash locales curl zip unzip && locale-gen de_DE.UTF-8

# Set Timezone
RUN \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install SDK
SHELL ["/bin/bash", "-c"]
RUN \
   curl -s "https://get.sdkman.io" | bash && \
   source "/root/.sdkman/bin/sdkman-init.sh" && \
   sdk install java $JAVA_VERSION && \
   sdk install grails $GRAILS_VERSION
