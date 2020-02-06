FROM alpine:3.9.5

ARG RUNTIME_DEPS="libintl git ca-certificates curl python3 jq apache2-utils bash sed"
ARG BUILD_DEPS="gnupg gettext go gcc musl-dev openssl py-pip python3-dev"
ARG GO_PATH="/go"
ARG KUBERNETES_VERSION="v1.15.3"
ARG HELM_VERSION="v3.0.3"
ARG AWS_IAM_AUTHENTICATOR="https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator"
ARG AWS_CLI_VERSION="1.17.9"

ENV PATH=${GO_PATH}/bin:${PATH}

ADD ./assume_role /usr/local/bin
ADD ./generate_kubeconfig /usr/local/bin

RUN apk update --quiet && \
    apk upgrade --quiet && \
    apk add --quiet --no-cache ${RUNTIME_DEPS} && \
    apk add --quiet --no-cache --virtual build-dependencies ${BUILD_DEPS} && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    curl -sL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl && \
    curl -sL -o /tmp/helm-${HELM_VERSION}-linux-amd64.tar.gz https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz && \
    cd /tmp && \
    tar -xzf /tmp/helm-${HELM_VERSION}-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    curl -sL -o /usr/local/bin/aws-iam-authenticator ${AWS_IAM_AUTHENTICATOR} && \
    chmod +x /usr/local/bin/kubectl /usr/local/bin/helm /usr/local/bin/aws-iam-authenticator /usr/local/bin/generate_kubeconfig /usr/local/bin/assume_role && \
    curl -sL -O https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    pip3 install --upgrade setuptools && \
    pip3 install awscli --upgrade && \
    apk del --quiet build-dependencies && \
    rm -rf /var/cache/apk/* /tmp/*

ENTRYPOINT []
