From node:14 as build

WORKDIR /APP

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:latest

COPY --from=build /APP/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]