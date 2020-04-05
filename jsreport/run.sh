# file run.sh
#!/bin/sh

if [ -d "/jsreport" ]; then
  # link data folder from mounted volume

  if [ ! -d "/jsreport/data" ]; then
    mkdir "/jsreport/data"
  fi

  ln -nsf "/jsreport/data" "/home/node/app/data"

  # copy default config
  if [ ! -f "/jsreport/jsreport.config.json" ]; then
    cp "/home/node/app/jsreport.config.json" "/jsreport/jsreport.config.json"
  fi

  
  ln -s "/jsreport/prod.config.json" "/home/node/app/prod.config.json"
  ln -s "/jsreport/dev.config.json" "/home/node/app/dev.config.json"
  ln -s "/jsreport/license-key.txt" "/home/node/app/license-key.txt"
  ln -s "/jsreport/jsreport.license.json" "/home/node/app/jsreport.license.json"

  rm -f "/home/node/app/jsreport.config.json"
  ln -s "/jsreport/jsreport.config.json" "/home/node/app/jsreport.config.json"

  chown -R node:node /jsreport
fi

su node

node "/home/node/app/server.js"