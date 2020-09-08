
#Deploy Kubeless
export RELEASE=$(curl -s https://api.github.com/repos/kubeless/kubeless/releases/latest | grep tag_name | cut -d '"' -f 4)
kubectl create ns kubeless
kubectl create -f https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless-$RELEASE.yaml
kubectl create -f https://raw.githubusercontent.com/kubeless/kubeless-ui/master/k8s.yaml

kubectl apply -f ./kubeless/Ingress.yaml

#Deploy EMQX
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3|bash
helm repo add emqx https://repos.emqx.io/charts
helm repo update
helm install emqx-cluster emqx/emqx --set persistence.enabled=true --set persistence.storageClass=longhorn --set service.type=LoadBalancer


kubectl apply -f ./emqx/Ingress.yaml
