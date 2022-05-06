#!/bin/bash

chmod 600 $PWD/MusicDBPythonServer.pem
ssh -i MusicDBPythonServer.pem -t ec2-user@ec2-54-183-137-34.us-west-1.compute.amazonaws.com './dedupe.sh && exit'


