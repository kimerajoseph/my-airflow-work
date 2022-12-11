#!/usr/bin/env bash
for node in `kubectl get nodes --label-columns=lifecycle --selector=lifecycle=Ec2Spot -o go-template='{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'` ; do
    kubectl taint nodes $node spotInstance=true:PreferNoSchedule

done