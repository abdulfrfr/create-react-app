FROM node AS prod
WORKDIR /app
RUN npm install -g npm@latest
COPY package*.json ./
RUN npm install
COPY . .
RUN npm install -g commander
# RUN npm test - if you want to test before to build
RUN npm run create-react-app demo
RUN npm run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=prod /app/build .
# run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]
