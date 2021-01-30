## Bootstrap

## Build

```
kubectl use

helm repo add argo-cd https://argoproj.github.io/argo-helm
helm dep update charts/argo-cd/
```


```
kind create cluster \
  --config ./local/kind.yaml \
  --name production \
  && kind create cluster \
    --config ./local/kind-public-apiserver.yaml \
    --name local-bootstrapper

kubectl config use-context kind-local-bootstrapper

helm upgrade -i argo-cd charts/argo-cd/ -n argocd --create-namespace 

helm template root apps/root -n argocd  | kubectl apply -f - -nargocd


kubectl port-forward svc/argo-cd-argocd-server 8080:443 -n argocd    

kubectl get pods -l app.kubernetes.io/name=argocd-server -o name -n argocd | cut -d'/' -f 2

# login

argocd login \
  localhost:8080 \
  --username admin \
  --password $(kubectl get pods -l app.kubernetes.io/name=argocd-server -o name -n argocd | cut -d'/' -f 2) \
  --name local-bootstrapper

```


* https://www.arthurkoziel.com/setting-up-argocd-with-helm/