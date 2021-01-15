FROM node:14-alpine as build-stage

RUN mkdir -p /usr/src/app
ENV PORT 3000

WORKDIR /usr/src/app

COPY package.json /usr/src/app

RUN npm install --production

COPY . /usr/src/app

RUN npm run build

EXPOSE 3000
CMD [ "npm", "start" ]

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /usr/src/app /src/realse
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
