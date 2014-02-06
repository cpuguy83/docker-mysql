docker-mysql
============
Builds a replication friendly MySQL container.  An image built from this can be any of master, slave, standalone.

### Usage
### Standalone Setup
Nothing special, just docker run this


#### Master Setup
To make something a master, you can run the image without any extra options.
You'll then you'll need to create the relevant mysql replication user and grant privileges.  You'll pass these into the slave container at runtime.<br />
You'll also need to get the current mysql binlog file and log position (hint: "SHOW MASTER STATUS").  This will also get passed into the slave at runtime.

#### Slave Setup
Once the master is setup you'll need to link the master container to the slave giving it an alias of "master"
```
docker run -link mysql_master:master
```
You'll also need to pass in envvars for MASTER_USER, MASTER_PASS, MASTER_LOG_FILE, MASTER_LOG_POS, and SERVER_ID<br />
If no master user or pass is passed in, we'll assume user: replication, pass: repl<br />
If no SERVER_ID is passed in, we assume 2  (master is 1 unless you specify otherwise).<br />
If you want to have the master on a different host (and as such docker linking won't work atm), you can pass in an envvar for MASTER_PORT_3306_TCP_ADDR and provide the master's IP address.
