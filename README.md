## Bootstrap

## Build

```

kind create cluster --config ./local/kind.yaml

helm repo add argo-cd https://argoproj.github.io/argo-helm
helm dep update charts/argo-cd/


helm upgrade -i argo-cd charts/argo-cd/ -n argocd --create-namespace

helm template root apps/root -n argocd  | kubectl apply -f - -nargocd


kubectl port-forward svc/argo-cd-argocd-server 8080:443 -n argocd    

kubectl get pods -l app.kubernetes.io/name=argocd-server -o name -n argocd | cut -d'/' -f 2

```


* https://www.arthurkoziel.com/setting-up-argocd-with-helm/