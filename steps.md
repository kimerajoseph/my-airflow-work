## common commands
NOTE: USE MASTER BRANCH
kubectl get namespace
fluxctl sync --k8s-fwd-ns flux (sink files instantly)

## export key pair
 aws ec2 import-key-pair --key-name="airflow-workstation" --public-key-material fileb:///home/ec2-user/.ssh/id_ed25519.pub

 # create cluster
 eksctl create cluster -f cluster.yml

## interact with cluster
kubectl get nodes

## creating namespaces
1. do not use kubectl
2. instead push the file to a github repo
3. check and confirm deployiment is ongoing (kubectl get pods -n flux)
4. kubectl logs -f flux-74bcbf5c98-4hdrt -n flux

