FROM node:10.13.0-alpine

### Disable Build in Services
    ENV FORMIO_VERSION=v1.33.5 \
        FORMIO_CLIENT_VERSION=master


#    RUN  set -x && adduser -h /app -g "Node User" -D nodejs
### Install Runtime Dependencies
    RUN apk add sudo
    RUN apk update && \
        apk add \
            expect \
            git \
            g++ \
            jq \
            make \
            python


     RUN   git clone -b $FORMIO_VERSION https://github.com/formio/formio.git /app/
     RUN   git clone -b $FORMIO_CLIENT_VERSION https://github.com/formio/formio-app-formio.git /app/client

     RUN   cd /app && npm install

### Misc & Cleanup
     RUN   mkdir -p /app/templates && \

#        chown -R nodejs. /app && \
        rm -rf /tmp/* \
        /var/cache/apk/*

    WORKDIR /app/

### Networking Configuration
    EXPOSE 3001 

### Add Files
    ADD install /

#CMD exec sudo -E -u nodejs HOME=/app npm start
CMD [ "npm" ,"start" ]