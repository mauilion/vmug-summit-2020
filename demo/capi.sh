#!/usr/bin/env bash

########################
# include the magic
########################
. lib/demo-magic.sh


########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
# TYPE_SPEED=20

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# hide the evidence
clear


# put your demo awesomeness here
#if [ ! -d "stuff" ]; then
#  pe "mkdir stuff"
#fi

#pe "cd stuff"

pe "kubectl apply -f capi-kind/capi/deploy"
pe "kubectl get pods -Aw | grep ^ca"
pe "kubectl apply -f capi-kind/cluster/"
pe "kubectl get machine -Aw"
pe "docker ps"
docker exec -ti c1-cp0 sed -i s#{{.*.}}#192.168.0.0/16# /kind/manifests/default-cni.yaml 1>/dev/null
docker exec -ti c1-cp0 kubectl apply -f /kind/manifests --kubeconfig /etc/kubernetes/admin.conf 1>/dev/null
. ~/.kube_functions
pe "capd-kubeconfig c1 c1"
export KUBECONFIG=~/.kube/config:c1.kubeconfig
pe "kubectl get nodes -o wide --context=c1-admin@c1"
pe "kubectl -n c1 scale machinedeployment worker --replicas=2"
pe "watch 'docker ps | grep worker'"
pe "kubectl get nodes -o wide --context=c1-admin@c1"
pe "kubectl config use-context c1-admin@c1"
pe "kubectl create deployment echo --image=inanimate/echo-server"
pe "kubectl scale deployment echo --replicas=4"
pe "kubectl expose deployment echo --port=8080 --type=NodePort"
p "Let's setup more of a demo here showing the power of orchestration"
# show a prompt so as not to reveal our true nature after
# the demo has concluded

p ""
