FROM node:6.9.1-alpine

ENV CLOUD_SDK_VERSION 162.0.0

ENV PATH /google-cloud-sdk/bin:$PATH

RUN apk --no-cache add curl python bash libc6-compat openssh-client git docker
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz
RUN \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image

RUN npm install -g yarn
RUN yarn global add @google-cloud/functions-emulator

ADD . /functions
WORKDIR /functions

ENTRYPOINT ["/bin/sh"]
