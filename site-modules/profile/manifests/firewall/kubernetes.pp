# Kubernetes Firewall

class profile::firewall::kubernetes {

  firewallchain { [
    'CNI-HOSTPORT-MASQ:nat:IPv4',
    'CNI-HOSTPORT-SETMARK:nat:IPv4',
    'DOCKER-ISOLATION-STAGE-1:filter:IPv4',
    'DOCKER-ISOLATION-STAGE-2:filter:IPv4',
    'DOCKER-USER:filter:IPv4',
    'DOCKER:filter:IPv4',
    'DOCKER:nat:IPv4',
    'KUBE-FIREWALL:filter:IPv4',
    'KUBE-FIREWALL:nat:IPv4',
    'KUBE-FORWARD:filter:IPv4',
    'KUBE-KUBELET-CANARY:filter:IPv4',
    'KUBE-KUBELET-CANARY:mangle:IPv4',
    'KUBE-KUBELET-CANARY:nat:IPv4',
    'KUBE-LOAD-BALANCER:nat:IPv4',
    'KUBE-MARK-DROP:nat:IPv4',
    'KUBE-MARK-MASQ:nat:IPv4',
    'KUBE-NODE-PORT:nat:IPv4',
    'KUBE-POSTROUTING:nat:IPv4',
    'KUBE-SERVICES:nat:IPv4',
    'WEAVE-IPSEC-IN-MARK:mangle:IPv4',
    'WEAVE-IPSEC-IN:filter:IPv4',
    'WEAVE-IPSEC-IN:mangle:IPv4',
    'WEAVE-IPSEC-OUT-MARK:mangle:IPv4',
    'WEAVE-IPSEC-OUT:mangle:IPv4',
    'WEAVE-NPC-DEFAULT:filter:IPv4',
    'WEAVE-NPC-EGRESS-ACCEPT:filter:IPv4',
    'WEAVE-NPC-EGRESS-CUSTOM:filter:IPv4',
    'WEAVE-NPC-EGRESS-DEFAULT:filter:IPv4',
    'WEAVE-NPC-EGRESS:filter:IPv4',
    'WEAVE-NPC-INGRESS:filter:IPv4',
    'WEAVE-NPC:filter:IPv4',
    'WEAVE:nat:IPv4' ]:
    ensure => present,
    purge  => false,
  }
}
