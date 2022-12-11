## STEPS

## AWS blog
https://aws.amazon.com/blogs/containers/running-airflow-workflow-jobs-on-amazon-eks-spot-nodes/

1. create .env file and input variables
create cluster
eksctl create cluster -f ekscluster.yaml 
eksctl delete cluster --region=eu-west-3 --name=airflow-eks-cluster

kubectl get nodes --label-columns=lifecycle --selector=lifecycle=Ec2Spot

Next, we’ll taint the Spot instances with PreferNoSchedule. This taint ensures only the pods that tolerate this taint run on Spot instances. All other pods will run on the On-Demand nodes.

for node in `kubectl get nodes --label-columns=lifecycle --selector=lifecycle=Ec2Spot -o go-template='{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'` ; do kubectl taint nodes $node spotInstance=true:PreferNoSchedule
done

## confirm node are tainted
kubectl describe node <node-name>
kubectl describe node ip-192-168-8-146.eu-west-3.compute.internal

kubectl describe node ip-192-168-80-106.eu-west-3.compute.internal > ec21.yaml

## SET ENV VARIABLES

In a similar manner, you can use envsubst.

apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: ${CLUSTER_NAME}
  region: eu-central-1

nodeGroups:
  - name: ${CLUSTER_NAME}-group-1
    [..]
  - name: ${CLUSTER_NAME}-group-2
    [..]


export CLUSTER_NAME=foo

cat cluster-config.yml | envsubst '${CLUSTER_NAME}' > cluster-config-foo.yml

## PREPARE ENVIRONMENT
Prepare environment
As we trigger Airflow workflows, we need to ensure that the EKS cluster has enough capacity to run workflows. The EKS data plane size should grow when the cluster runs out of capacity, and it should remove nodes when they are not required.

We’ll use cluster autoscaler to autoscale the EKS data plane. The cluster autoscaler automatically adds nodes in your cluster when pods fail to launch due to a lack of resources. Conversely, it will remove nodes when they are underutilized, and their pods can be rescheduled onto other nodes in the cluster.

Airflow needs persistent storage to store its data and configurations. We will use Amazon EFS to provide persistent storage for the Airflow pod. Airflow uses PostgresSQL database to store metadata. We will create an Amazon RDS PostgreSQL to use with Airflow.

## AUTOSCALER LINK
https://docs.aws.amazon.com/eks/latest/userguide/autoscaling.html#cluster-autoscaler