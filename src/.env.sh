# Test settings
# 1. set `RUN_REMOTELY=1` to run tests on remote machine
export RUN_REMOTELY=0
export REMOTE_USER_NAME=''
export REMOTE_CLUSTER_IP=''

# 2. set `MOCKING=0` to run real test cases
export MOCKING=1

# Generic environment settings
# 1. Hadoop
export HADOOP_CLUSTER_KEY='<key.pem>'
export HADOOP_CLUSTER_USER='<user-name>'
export HADOOP_CLUSTER_IP='<ip>'

# 2. kafka
export KAFKA_BOOTSTRAP_SERVERS='<ip>:9092'

# 3. App insights
export APP_INSIGHT_BUILD_ID='<app insight build id>'
export APP_INSIGHT_INSTRUMENTATION_KEY='<app insight instrumentation key>'