FROM node:alpine

ENV PORT 8080

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE $PORT

LABEL "traefik.port" $PORT
LABEL "traefik.enable" "true"
LABEL "traefik.protocol" "http"
LABEL "traefik.frontend.entryPoints" "https"
LABEL "traefik.frontend.passTLSCert" "true"

CMD [ "npm", "start" ]
