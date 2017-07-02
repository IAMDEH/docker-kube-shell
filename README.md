# Supported tags and respective `Dockerfile` links

  * [`1`, `1.7`, `1.7.0`, `latest`](https://github.com/alexei-led/docker-kube-shell/blob/master/Dockerfile) [![](https://images.microbadger.com/badges/image/alexeiled/kubeshell:1.7.svg)](https://microbadger.com/images/alexeiled/kubeshell "Get your own image badge on microbadger.com")
  * [`1.6`, `1.6.4`](https://github.com/alexei-led/docker-kube-shell/blob/master/Dockerfile) [![](https://images.microbadger.com/badges/image/alexeiled/kubeshell:1.6.svg)](https://microbadger.com/images/alexeiled/kubeshell "Get your own image badge on microbadger.com")
  
## What is `kube-shell`

[kube-shell](https://github.com/cloudnativelabs/kube-shell) is an interactive shell on top of `kubectl` (a CLI tool to control a cluster [Kubernetes](http://kubernetes.io/)).

## Usage

    $ docker run --rm --net=host --user $UID -v $HOME/.kube:/config/.kube alexeiled/kubeshell

Note: Entrypoint is set to `kube-shell`

* `-net=host`: (optional) allows to connect to a local Kubernetes cluster.
* `--user $UID`: (optional) by default runs as random UID `2342`, this allows to access your existing `~/.kube` if you have one. As you can note, you can run `kubectl` as any UID/GID.
 * `-v XXX:/config`: (optional) allows to store its configuration and possibly access existing configuration. Note that `/config` will always be the directory containing `.kube` (it's the forced `HOME` directory). Can be read-only. Alternatively you can mount a Kubernetes service account for example: `-v /var/run/secrets/kubernetes.io/serviceaccount:/var/run/secrets/kubernetes.io/serviceaccount:ro`.

### Usage with Minikube

For example to access a `minikube` Kubernetes cluster you may run:

    $ docker run --rm --net=host --user $UID -v $HOME/.kube:/config/.kube -v $HOME/.minikube:$HOME/.minikube alexeiled/kubeshell

*Note*: need to add a `$HOME/.minikube` volume with the same name inside the Docker container, since it contains required certificates with fully qualified path)

### Usage with service-account

Here we use the service-account, so this should work from within a Pod on your cluster as long as you've docker installed (and may be `DOCKER_HOST` set up properly):

    $ docker run \
        -v /var/run/secrets/kubernetes.io/serviceaccount/:/var/run/secrets/kubernetes.io/serviceaccount/:ro \
        alexeiled/kubeshell \
        -s https://kubernetes \
        --token="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
        --certificate-authority=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt

## Feedbacks

Suggestions are welcome on our [GitHub issue tracker](https://github.com/alexei-led/docker-kube-shell/issues).