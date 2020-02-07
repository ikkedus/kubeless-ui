FROM bitnami/node:8 as builder

RUN apt-get update
RUN apt-get install -y git

RUN git clone https://ikkedus:Voc@l0id39@github.com/ikkedus/kubeless-ui.git app

WORKDIR /app

ENV NODE_ENV=production
RUN npm install yarn --global && \
    yarn install && \
    npm rebuild node-sass && \
    yarn run build

FROM bitnami/node:8-prod

LABEL maintainer "Bitnami Team <containers@bitnami.com>"

WORKDIR /app

COPY --from=builder /app /app

ENV NODE_ENV=production
RUN npm install yarn --global

ENTRYPOINT ["yarn","run","start"]
