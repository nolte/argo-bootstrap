# Local Dev Env

```
task \
  kind:destroy \
  kind:create \
  boostrap:boostrap-argocd \
  argo:portorward \
  argo:login \
  argo:addcluster
```

## Start 

Wir Starten 2 Lokale k8s Cluster.

```sh
kind create cluster \
  --config ./local/kind.yaml \
  --name production \
  && kind create cluster \
    --config ./local/kind-public-apiserver.yaml \
    --name local-bootstrapper
```
**Boostrap Cluster Context**
```sh
kubectl config use-context kind-local-bootstrapper
```

**Production Cluster Context**

```sh
kubectl config use-context kind-production
```

### Argo

#### Install

```
kubectl config use-context kind-local-bootstrapper

helm upgrade \
  -i argo-cd src/charts/technical/argo-cd/ \
  -n argocd --create-namespace \
  -f src/charts/technical/argo-cd/values.yaml \
  -f src/charts/technical/argo-cd/values-bootstrap.yaml \
  --wait
```

#### PortForward

```
kubectl port-forward svc/argo-cd-argocd-server 8080:443 -n argocd
```

#### Login

```
argocd login \
  localhost:8080 \
  --username admin \
  --password $(kubectl get pods -l app.kubernetes.io/name=argocd-server -o name -n argocd | cut -d'/' -f 2) \
  --name local-bootstrapper
```

#### Add Cluster

```
kubectl config use-context kind-production
argocd cluster add kind-production
```

## Cleanup

```
kind delete cluster --name production \
  && kind delete cluster --name local-bootstrapper
```
