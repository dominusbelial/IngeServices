FROM node:12-alpine

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

COPY package*.json ./

RUN npm install --ignore-scripts

COPY --chown=node:node . .

EXPOSE 3002

CMD ["npm","run","dev"]