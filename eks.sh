#!/bin/bash
#!/bin/bash

create_cluster() {
    eksctl create cluster --name=eks-cluster \
        --region=ap-south-1 \
        --nodegroup-name=my-nodes \
        --node-type=t3.medium \
        --managed \
        --nodes=2 \
        --nodes-min=2 \
        --nodes-max=3
}

delete_cluster() {
    eksctl delete cluster --name=eks-cluster --region=ap-south-1
}

if [ "$1" = "build" ]; then
    create_cluster
elif [ "$1" = "delete" ]; then
    delete_cluster
else
    echo "Usage: $0 {build|delete}"
    exit 1
fi
