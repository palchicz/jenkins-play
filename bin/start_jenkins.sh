#!/usr/bin/env bash

bin=`dirname $0`
bin=`cd "$bin" && pwd`
root="$bin/.."
root=`cd "$root" && pwd`

java -jar $root/jenkins.war --httpPort=8082
