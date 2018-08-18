# Distributed Groceries

## Description

This is the example app that was built in this post
[https://mccalljt.io/blog/2018/08/distributed_phoenix_app](https://mccalljt.io/blog/2018/08/distributed_phoenix_app)

## Setting up the Swarm

```
# Get the Docker Engine in Swarm mode
% swarm init

# Create our Registry
% docker service create --name registry --publish published=5000,target=5000 registry:2

# Build our app
% docker-compose build app

# Push our app to our local Registry
% docker-compose push

# Start our stack
% docker stack deploy -c docker-compose.yml distributed_groceries

# Check if its working
% docker service ls
ID                  NAME                        MODE                REPLICAS            IMAGE                                         PORTS
vqh8kc006kbg        distributed_groceries_app   replicated          3/3                 127.0.0.1:5000/distributed_groceries:latest   *:4000->4000/tcp
mpmamnzhskqq        registry                    replicated          1/1                 registry:2                                    *:5000->5000/tcp

```
You can now run requests against `localhost`:

```
% curl -X POST \
  http://0.0.0.0:4000/grocery_lists \
  -H 'Content-Type: application/json' \
  -d '{ "name": "new_list" }'

"Success!: new_list was created"
```
