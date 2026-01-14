FROM eclipse-temurin:25-jre

# Install required packages
RUN apt-get update && \
    apt-get install -y ca-certificates unzip wget && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /hytale

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME ["/hytale"]

ENTRYPOINT ["/entrypoint.sh"]