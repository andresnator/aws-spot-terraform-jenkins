#!/bin/bash
cd /tmp/
sudo mkdir jenkins_home
sudo chmod +x -R jenkins_home
ls -lh
sudo docker-compose up -d