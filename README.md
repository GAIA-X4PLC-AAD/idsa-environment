# Kubernetes scripts deployment

## Prerequisites
In order to deploy the k8s scripts, you will need the following:

- A cloud infrastructure like Azure or AWS
- A k8s cluster where you are able to deploy containers

## Important information
The broker-frontend deployment currently uses a privately hosted docker image.
Therefore, you won't be able to deploy this component right now.
We are working on a globally accessible Docker image solution.
For now, if you want to deploy the broker-frontend component, you can use this globally accessible Docker image our Docker image is based on:

`registry.gitlab.cc-asp.fraunhofer.de/eis-ids/broker/frontend-mobids:5.0.0-RELEASECANDIDATE`

... and fix the errors by yourself. :)

## How to deploy the k8s scripts
Firstly, you need to connect your local machine to your cloud infrastructure via ssh like this:

`ssh -i '<path to ssh rsa file>' -L localhost:<port>:<ip address>:<port> <user>@<ip address>`

Then, you may use the ps1 scripts located in `idsa/src/k8s`. In this case you need to execute them in the following order:

1. `create_namespace.ps1`
2. `apply_azure_storage-classes.ps1`
3. `apply_broker.ps1`, `apply_daps.ps1`

If you are using AWS, you maybe need to change some things in order to get the deployment scripts working, e.g. the storage-class files.

In order to delete the broker and daps k8s deployments, simply run the `delete_namespace.ps1` script. It will take a while until everything is deleted, though.
We recommend to use a k8s IDE like Lens.