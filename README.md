## Bootstrap

## Build

```
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm dep update charts/argo-cd/


kubectl create ns argocd

helm install argo-cd charts/argo-cd/ -n argocd --create-namespace

helm upgrade -i argo-cd charts/argo-cd/ -n argocd --create-namespace


helm template argo-cd charts/argo-cd/ -n argocd | kubectl apply -f - -n argocd 

helm template root apps -n argocd  | kubectl apply -f - -nargocd
 | kubectl apply -f -

```

argo-cd-argocd-server-546545dff8-dmljk


* https://www.arthurkoziel.com/setting-up-argocd-with-helm/