##  IDSA Dataspace Connector Usage Example

This example runs 2 dataspace connectors and shows some basic usage between the connectors and the IDS Broker and DAPS. 
The Broker and DAPS are hosted into the common Gaia-X Environment of the PLC-AAD Project:

DAPS URL: https://www.gxfs.gx4fm.org/idsa-daps/auth/jwks.json
Broker URL: https://www.gxfs.gx4fm.org/idsa-broker-ui/

The example is taken and adapted from the IDS Testbed (see https://github.com/International-Data-Spaces-Association/IDS-testbed). 
For more detailed information about IDS see the Testbed documentation and other IDS related github repositories. 

### Startup and Configuration 

The default configuration works out of the box. For better recognition of the connectors adjust the config.json and 
change the title of the connectors:
```json-ld
"ids:title": [ {
"@value" : "msg Demo Dataspace Connector",
"@type" : "http://www.w3.org/2001/XMLSchema#string"
} ]
```

The connectors will be started with the following compose command:
```sh
docker-compose --project-name connector-example up -d
```
Connector A will be accessible via port 9080 and Connector B via port 9081.

### Example Usage

In the following examples demonstrates the usage and shows some base commands:

Read Self Description of the Connectors:
```sh
curl -k -u "admin:password" https://localhost:9080/api/connector
curl -k -u "admin:password" https://localhost:9081/api/connector
```

Read Self Description of Connector A via Connector B
```sh
curl -X POST -k -u "admin:password" "https://localhost:9081/api/ids/description?recipient=https://connectora:8080/api/ids/data"
```

Register Connector A at the Broker. After registering, the connector will be visible at the 
broker: https://www.gxfs.gx4fm.org/idsa-broker-ui

```sh
curl -X POST -k -u "admin:password" "https://localhost:9080/api/ids/connector/update?recipient=https://www.gxfs.gx4fm.org/idsa-broker-api/infrastructure"
```
