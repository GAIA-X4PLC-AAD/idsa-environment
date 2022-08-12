## Kubernetes Scripts Deployment
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

### How to access the software
#### Cloud environment
You can access the software from your web browser with this url name schema:

`https://<host name>/<ingress path>/`

There are the following Ingress paths defined:
* `https://<host name>/idsa-broker-ui/`
* `https://<host name>/idsa-broker-api/`
* `https://<host name>/idsa-daps/`

#### Local environment
There is no direct external access. If you want to access the software from your web browser, please run this command first:

`kubectl proxy --port=8080`

This will start the Kubernetes Proxy. If needed, you can choose a different port number. Now, you will be able to navigate through the Kubernetes API to access the deployed services using this scheme:

`http://localhost:8080/api/v1/namespaces/gxfs-idsa/services/<service name>:<port number>/proxy/`

The available service names and their port numbers are:
* `broker-core-service:8080`
* `broker-elasticsearch-service:9200`
* `broker-frontend-service:80`
* `broker-fuseki-service:3030`
* `broker-mongodb-handler-service:4000`
* `broker-mongodb-service:27017`
* `daps-proxy-service:80`
* `daps-server-app-service:4567`
* `daps-ui-app-service:80`

### How to delete the deployed containers
In order to delete the broker and daps k8s deployments, simply run the `delete_namespace.ps1` script. It will take a while until everything is deleted, though. You will have to wait until everything is removed before recreating the namespace and applying the kubernetes scripts again. If there are only minor changes, you may only have to reapplying the kubernetes scripts instead of deleting the namespace.

### Tips
We recommend to use a k8s-based IDE like Lens. Managing and debugging k8s units is a lot easier using one.

### Troubleshooting
If there are some problems, here are some ideas for troubleshooting:
* It may take some time to get every container running. Expecially when deploying them for the first time, some of the containers may take about 5 minutes to start.
* Please check if you are using the correct storage class provider. In this repository you will only find the storage classes for the Azure and minikube provider.
* The mongodb-handler only works correctly if the mongodb is up and running. Therefore, some restarts of the mongodb-handler Pod may be normal.
* Check the Pod Logs of the Pods

# CI Test
