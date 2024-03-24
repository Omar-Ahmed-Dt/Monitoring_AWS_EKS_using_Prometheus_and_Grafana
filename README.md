# Monitoring AWS EKS using Prometheus and Grafana
**Prerequisites :**
- eksctl
- kubectl
- aws cli
- helm
---
## Creating an Amazon EKS Cluster using eksctl : 
```
./eks.sh build
```
- this command will run : 
```
    eksctl create cluster --name=eks-cluster \
        --region=ap-south-1 \
        --nodegroup-name=my-nodes \
        --node-type=t3.medium \
        --managed \
        --nodes=2 \
        --nodes-min=2 \
        --nodes-max=3
```
<img src=imgs/eks_eksctl.png>

## Add Helm Stable Charts for Your Local Client : 
```
helm repo add stable https://charts.helm.sh/stable

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

```
## Install Prometheus using Helm : 
```
helm install stable prometheus-community/kube-prometheus-stack -n prometheus
```
<img src=imgs/prometheus-pods.png>

```
kubectl get svc -n prometheus
```

## Expose Prometheus and Grafana to the external world : 
- to attach the load balancer we need to change from ClusterIP to LoadBalancer
command to get the svc file: 
```
kubectl edit svc stable-kube-prometheus-sta-prometheus -n prometheus
```
<img src=imgs/lb.png>

<img src=imgs/pro-svc.png>

<img src=imgs/pro.png>

```
kubectl edit svc stable-grafana -n prometheus
```
<img src=imgs/gra-svc.png>

```
kubectl get svc -n prometheus stable-grafana

kubectl get secret --namespace prometheus stable-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

```

<img src=imgs/gra.png>
<img src=imgs/graphs.png>

## Clean up/Deprovision-Deleting the Cluster : 
```
./eks.sh delete
```
- this command will run: 

```
eksctl delete cluster --name eks-cluster
```
