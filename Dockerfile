FROM "openjdk:10.0.1-jdk-slim"

LABEL maintainer="petitviolet <mail@petitviolet.net>"
LABEL description="Scala+sbt image"

ENV SCALA_VERSION 2.12.6
ENV SBT_VERSION 1.1.6

# Install curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Install Scala
RUN curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  cp /root/scala-$SCALA_VERSION/bin/* /usr/local/bin/

# Install sbt
RUN curl -fsL https://piccolo.link/sbt-$SBT_VERSION.tgz | tar xfz - -C /root/ && \
  /root/sbt/bin/sbt sbtVersion && \
  cp /root/sbt/bin/* /usr/local/bin/

# prepare source code container
RUN mkdir -p /usr/local/src

WORKDIR /usr/local/src

CMD ['/usr/local/bin/sbt']
