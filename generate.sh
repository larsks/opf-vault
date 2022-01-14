#!/bin/sh

kustomize build --enable-helm | sed 's|policy/v1beta1|policy/v1|g' > manifests.yaml

rm -rf out
mkdir -p out/cluster-scope out/vault

echo "Adding cluster-scoped resources..."
halberd -v -d out/cluster-scope -N manifests.yaml

echo "Adding namespaced resources..."
halberd -v -d out/vault -n manifests.yaml

echo "Adding route..."
halberd -v -d out/vault route.yaml

echo "Adding namespace..."
halberd -v -d out/cluster-scope namespace.yaml
