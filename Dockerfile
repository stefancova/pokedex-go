FROM node:6-alpine

EXPOSE 5555
WORKDIR /app
ADD . /app
RUN npm install

CMD npm start

