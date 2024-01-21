FROM node AS prod
WORKDIR /app
COPY package*.json ./
RUN yarn install
COPY . .
# RUN npm test - if you want to test before to build
RUN yarn run create-react-app
RUN yarn run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=prod /app/build .
# run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]
