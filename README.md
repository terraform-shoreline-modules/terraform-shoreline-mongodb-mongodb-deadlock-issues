
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# MongoDB Deadlock Issues
---

MongoDB Deadlock Issues typically occur when two or more database operations are waiting for each other to release a resource, resulting in a situation where none of the operations can proceed. This can cause the database to freeze or become unresponsive, leading to downtime or degraded performance for applications that rely on it. Deadlocks can occur due to a variety of factors, including inefficient queries, poor database design, and high levels of concurrency. Resolving MongoDB deadlock issues requires careful analysis and tuning of the database configuration and application code to minimize contention and ensure efficient resource utilization.

### Parameters
```shell
export MONGODB_URI="PLACEHOLDER"
```

## Debug

### Check running processes and their resource usage
```shell
sudo top
```

### Check MongoDB logs for any error messages
```shell
sudo tail -f /var/log/mongodb/mongod.log
```

### Check MongoDB server status
```shell
sudo systemctl status mongod
```

### Check MongoDB database and collection statistics
```shell
mongo --eval "db.stats()"
```

### Check MongoDB indexes
```shell
mongo --eval "db.collection.getIndexes()"
```

### Check the output of the current operation in MongoDB
```shell
mongo --eval "db.currentOp()"
```

### Check if there are any locks on the MongoDB database or collection
```shell
mongo --eval "db.currentOp({'$all': true, 'waitingForLock': true})"
```

### Check if there are any blocked or waiting operations in MongoDB
```shell
mongo --eval "db.currentOp({'$all': true, 'waitingForLock': true, 'active': true})"
```

### Check if there are any active transactions in MongoDB
```shell
mongo --eval "db.currentOp({'$all': true, 'active': true, 'txnNumber': {'$gt': 0}})"
```

### Check if there are any slow queries in MongoDB
```shell
mongo --eval "db.currentOp({'$all': true, 'op': 'query', 'millis': {'$gt': 1000}})"
```

## Repair

### Tune the MongoDB server parameters, such as the lock timeout and the maximum number of connections, to improve its performance and avoid deadlocks.
```shell


#!/bin/bash



# Set the MongoDB lock timeout parameter to 30 seconds

mongo ${MONGODB_URI} --eval "db.adminCommand({setParameter: 1, maxWriteLockTimeoutMS: 30000})"



# Set the maximum number of MongoDB connections to 1000

mongo ${MONGODB_URI} --eval "db.adminCommand({setParameter: 1, maxConns: 1000})"


```