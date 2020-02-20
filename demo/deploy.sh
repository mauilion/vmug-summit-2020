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

pe "kind create cluster --config capi-kind/capi/config.yaml --name=capi"
pe "kubectl create deployment simplewebapp --image=mauilion/simplewebapp:master"
pe "kubectl scale deployment simplewebapp --replicas=3"
pe "kubectl expose deployment simplewebapp --port=80 --type=NodePort"
killall octant
pe "octant 2>/dev/null &"
p "check out octant.dev"
killall octant
xdg-open http://$(kubectl  get nodes capi-control-plane -o jsonpath='{.status.addresses[0].address}'):$(kubectl get svc simplewebapp -o jsonpath='{.spec.ports[0].nodePort}')  2>/dev/null 
pe "vim webapp/index.html"
pe "docker build -t mauilion/simplewebapp:kube webapp/"
pe "docker push mauilion/simplewebapp:kube"
pe "kubectl  set image deploy/simplewebapp simplewebapp=mauilion/simplewebapp:kube"
# show a prompt so as not to reveal our true nature after
# the demo has concluded
p "done for now"
cat capi-kind/capi/images.list | xargs -I {} kind --name=capi load docker-image {}
