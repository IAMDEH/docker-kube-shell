FROM alpine:3.6

RUN apk add --no-cache python py2-pip curl ca-certificates
RUN pip install kube-shell

ENV HOME=/config

ARG KUBE_VER=v1.7.0
ADD https://storage.googleapis.com/kubernetes-release/release/${KUBE_VER}/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN chmod +x /usr/local/bin/kubectl && adduser kubectl -Du 2342 -h /config

USER kubectl

ENTRYPOINT kube-shell
