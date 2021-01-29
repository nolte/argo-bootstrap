## Bootstrap

## Build

```
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm dep update charts/argo-cd/

helm upgrade -i argo-cd charts/argo-cd/ -n argocd --create-namespace 

```