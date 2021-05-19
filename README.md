# hpcc-docker-small

Provides a quick start script to start a single node HPCC Systems Cluster on docker.

### Usage

`docker-compose up` - Start

`docker-compose down` - Stop

Note: If you see that the cluster isn't closing properly, feel free to increase `stop_grace_period` in [docker-compose.yml](docker-compose.yml)