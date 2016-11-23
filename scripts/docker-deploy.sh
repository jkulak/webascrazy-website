#!/usr/bin/env bash

docker push jkulak/webascrazy-web

ssh -oStrictHostKeyChecking=no deploy@$DEPLOY_HOST << EOF

    docker pull jkulak/webascrazy-web:latest
    docker stop webascrazy-web || true
    docker rm webascrazy-web || true
    docker rmi jkulak/webascrazy-web:current || true
    docker tag jkulak/webascrazy-web:latest jkulak/webascrazy-web:current
    docker run -d --restart always --name webascrazy-web -p 20204:80 jkulak/webascrazy-web:current
EOF
