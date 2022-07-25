# IDSA test environment

## Introduction
This repository contains Kubernetes scripts for a test deployment of the IDSA components for the Metadata Broker and DAPS functionality.

## IDSA Components
The following are the IDSA components which are deployed in this test environment. Please read the documentation provided in the given links in order get more information about the used software.

* [IDSA Metadata Broker](https://github.com/International-Data-Spaces-Association/metadata-broker-open-core)
  * broker-core
  * broker-fuseki
  * broker-elasticsearch
  * broker-mongodb
  * broker-mongodb-handler
  * broker-frontend

* [IDSA Omejdn DAPS](https://github.com/International-Data-Spaces-Association/omejdn-daps)
  * omejdn-proxy
  * omejdn-server
  * omejdn-ui

## Kubernetes scripts deployment

### Prerequisites
In order to deploy the k8s scripts, you will need the following:

* A k8s cluster where you are able to deploy containers ([minikube](https://minikube.sigs.k8s.io/docs/start/), [Managed Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-cli), ...)
* [Docker Desktop](https://www.docker.com/blog/getting-started-with-docker-desktop/)

### Important information
If you are using AWS or a local environment, you maybe need to change some things in order to get the deployment scripts working, e.g. the storage-class files. The PS1 scripts and current settings are optimized for the usage on an Azure infrastructure (AKS).

### How to deploy the k8s scripts

#### Connect to the cluster inside a cloud infrastructure
This step is only needed if you want to deploy the components into a cluster inside a cloud infrastructure like Azure or AWS. You first need to connect your local machine to your cluster via ssh like this:

`ssh -i '<path to ssh rsa file>' -L localhost:3500:<cloud infrastructure k8s cluster ip address>:<cloud infrastructure k8s cluster port> <cloud infrastructure user>@<cloud infrastructure ip address>`

Follow the next steps after you have established a connection to your cloud cluster.

#### Execute the PS1 scripts
You may use the ps1 scripts located in `idsa/src/k8s`. In this case you need to execute them in the following order:

1. `create_namespace.ps1`: With this, you will create a namespace in your cluster for an easier management of the deployed components
3. `apply_azure_storage-classes.ps1` or `apply_minikube_storage-classes.ps1`: These will create the needed storage classes for the usage in AKS or local minikube cluster
5. `apply_broker.ps1` and `apply_daps.ps1`: These will deploy the Broker and DAPS components in the namespace

### How to delete the deployed containers
In order to delete the broker and daps k8s deployments, simply run the `delete_namespace.ps1` script. It will take a while until everything is deleted, though.

### Tips
We recommend to use a k8s-based IDE like Lens. Managing and debugging k8s units is a lot easier using one.

## IDSA Dataspace Connector Usage Example
Please refer to the following [README file](https://github.com/GAIA-X4PLC-AAD/idsa-environment/tree/main/idsa/src/docker-compose/connector-example) in order to get more information on this topic.
