# MegaCache

Mega Cache is a key/value store that relies upon the availability of the underlying file system.

When used as currently build and tested with AWS ECS and AWS EFS you'll get a fairly simple system with decent storage power. Biggest advantage is low cost to operate and run.

API Request -> Load Balancer -> ECS Task -> EFS FileSystem

That's the entire setup. With copies of the ECS Task to fan out load. 

See AWS docs on EFS for why this is okay doke.

## Installation

Currently only ran locally.  Assumption is this would deploy and run on its own. It is not yet part of any running Elixir Application. Rather it will be used as a key/value store for an existing system to reduce costs against things like DynamoDB.

To install there is an assumption of some knowledge of how file system and docker mounts work. The info below is specific to AWS and ECS tasks. 

### AWS and ECS Tasks

See the specifics below, in each section. 

1. Setup Docker
2. Setup Filesystem
3. Setup ECS Task Definition
4. Deploy ECS Task

#### Docker Setup

Here is how you can build the docker parts

* `docker build -t REPO/image_name:version .`
* `docker push REPO/image_Name:version`

#### Setup FileSystem

It is expected you'll setup an AWS EFS that can be mounted by many containers at once.  So far EFS seems to be able to handle the load of many processes running against the same file system at the same time.

#### Setup ECS Task Definition

Next you need to setup a task definition that uses the docker container, sets the environment variables, and mounts the EFS file system to the container.

#### Deploy ECS Task

Finally you can deploy the task. Note that you'll want a load balancer and probably 3 nodes of containers. Your call though. :wink:

