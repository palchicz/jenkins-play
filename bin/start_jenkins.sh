#!/usr/bin/env bash
# Note, this script assumes the jenkins war lives in the root directory

bin=`dirname $0`
bin=`cd "$bin" && pwd`
root="$bin/.."
root=`cd "$root" && pwd`

java -jar $root/jenkins.war --httpPort=8082
