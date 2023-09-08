
@test "ts1001 check if spark version is 3.4.1" {
  . run.sh ts1001.sh
}

@test "ts1002 check if spark can be started and then immediately exited" {
  . run.sh ts1002.sh
}

@test "ts1003 check if spark can do a basic Spark computation" {
  . run.sh ts1003.sh
}

@test "ts1004 check if spark can read from local filesystem" {
  . run.sh ts1004.sh
}

@test "ts1005 check if spark can write to local filesystem" {
  . run.sh ts1005.sh
}

@test "ts1006 check if spark can use all available CPU cores" {
  . run.sh ts1006.sh
}

@test "ts2001 verify zookeeper connection" {
  . run.sh ts2001.sh
}

@test "ts2002 check if broker number is 2" {
  . run.sh ts2002.sh
}

@test "ts2003 check if Kafka is Accepting Connections" {
  . run.sh ts2003.sh
}

@test "ts2004 Check Default Topic Configuration[retention time]" {
  . run.sh ts2004.sh
} 

@test "ts3001 check kubenetes nodes are ready" {
  . run.sh ts3001.sh
}

@test "ts3002 check k8s version" {
  . run.sh ts3002.sh
}

@test "ts3003 check if node number is 3" {
  . run.sh ts3003.sh
}