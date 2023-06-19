@test "TC0001 check if hadoop version is 3.3.2" {
  . run.sh ts0001.sh
}

@test "TC0002 check if hive version is 3.1.2" {
  . run.sh ts0002.sh
}

@test "TC0003 check if spark version is 3.1.2" {
  . run.sh ts0003.sh
}

@test "TC0004 check if hbase version is 2.4.5" {
  . run.sh ts0004.sh
}

@test "TC0005 check if zookeeper version is 2.4.13" {
  . run.sh ts0005.sh
}

@test "TC0006 check if telemetry can be sent to app insights" {
  . run.sh ts0010.sh
}

@test "TC0007 check if telemetry sending can be stopped" {
  . run.sh ts0007.sh
}