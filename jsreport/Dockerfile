FROM node:12-alpine
EXPOSE 5488

RUN apk update --no-cache && apk upgrade --no-cache  && \
  echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
  echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
  apk add --no-cache \
    chromium@edge=79.0.3945.130-r0 \
    nss@edge \
    freetype@edge \
    harfbuzz@edge \
    ttf-freefont@edge \
    # just for now as we npm install from git
    git \
    # so user can docker exec -it test /bin/bash
    bash \
  && rm -rf /var/cache/apk/* /tmp/*

VOLUME ["/jsreport"]

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

RUN npm install -g jsreport-cli --ignore-scripts && \
    jsreport init && \
    npm uninstall -g jsreport-cli && \
    npm cache clean -f

COPY --chown=node:node . .

RUN npm install --ignore-scripts

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

RUN npm i handlebars-intl --save --ignore-scripts   
COPY jsreport.config.json /home/node/app

COPY editConfig.js /home/node/app/editConfig.js
RUN node editConfig.js

ADD run.sh /home/node/app/run.sh

ENV NODE_ENV production
ENV chrome:launchOptions:executablePath /usr/lib/chromium/chrome
ENV chrome_launchOptions_args --no-sandbox,--disable-dev-shm-usage

CMD ["bash", "/home/node/app/run.sh"]