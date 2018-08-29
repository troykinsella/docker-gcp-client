FROM ubuntu:bionic

ENV CLOUD_SDK_REPO="cloud-sdk-bionic"
ENV HELM_VERSION=2.10.0

# Install Google Cloud SDK
RUN set -eux; \
    apt-get update; \
    apt-get install -y \
      curl \
      gnupg; \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | \
         tee -a /etc/apt/sources.list.d/google-cloud-sdk.list; \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -; \
    apt-get update; \
    apt-get install -y google-cloud-sdk;

# Install kubectl
RUN set -eux; \
    apt-get install -y kubectl; \
    apt-get clean;

# Install Helm
ADD https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz /tmp
RUN set -eux; \
    cd /tmp; \
    tar -zxf helm-v${HELM_VERSION}-linux-amd64.tar.gz; \
    mv linux-amd64/helm /usr/local/bin; \
    chmod +x /usr/local/bin/helm; \
    rm -rf /tmp/*;
