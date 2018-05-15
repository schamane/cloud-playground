FROM node:alpine

ENV PORT 8443

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE $PORT

LABEL "traefik.port" $PORT
LABEL "traefik.enable" "true"
LABEL "traefik.protocol" "https"
LABEL "traefik.backend" "xn3"
LABEL "traefik.frontend.rule" "Host:xn3.n1.easyoam.de"
LABEL "traefik.frontend.entryPoints" "https"
LABEL "traefik.frontend.passTLSCert" "false"

CMD [ "npm", "start" ]
