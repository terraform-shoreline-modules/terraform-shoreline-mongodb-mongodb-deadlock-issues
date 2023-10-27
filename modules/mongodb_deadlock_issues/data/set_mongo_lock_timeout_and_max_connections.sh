

#!/bin/bash



# Set the MongoDB lock timeout parameter to 30 seconds

mongo ${MONGODB_URI} --eval "db.adminCommand({setParameter: 1, maxWriteLockTimeoutMS: 30000})"



# Set the maximum number of MongoDB connections to 1000

mongo ${MONGODB_URI} --eval "db.adminCommand({setParameter: 1, maxConns: 1000})"