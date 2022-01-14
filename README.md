# Deploy Vault Server on OpenShift

This mostly follows
https://www.vaultproject.io/docs/platform/k8s/helm/openshift. The manifests
were generated using Kustomize's helm chart support with the following
configuration (or something very much like it; see the `generate` branch for
the current configuration):

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

helmCharts:
  - name: vault
    releaseName: opf
    repo: https://helm.releases.hashicorp.com
    includeCRDs: true
    valuesInline:
      global:
        openshift: true
      injector:
        enabled: false
      ui:
        enabled: true
      server:
        ha:
          enabled: true
          raft:
            enabled: true
        route:
          enabled: true
```

## Post-install configuration

- Follow https://www.vaultproject.io/docs/platform/k8s/helm/openshift to
  join the vault pods to a cluster  and initialize and unseal the vault.

- Store the unseal keys and root token in a secure location (such as BitWarden).

- Configure the Kubernetes auth provided as described in
  https://www.vaultproject.io/docs/auth/kubernetes

- Configure additional auth providers
