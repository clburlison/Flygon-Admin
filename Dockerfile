FROM node:18-alpine as client
WORKDIR /app
COPY ./client ./client
RUN cd client && yarn install
RUN cd client && yarn build

FROM golang:1.20.2-alpine3.17 as server
WORKDIR /app
COPY . .
RUN cd server && go build -o Admin

FROM golang:1.20.2-alpine3.17
COPY --from=client /app/dist ./dist
COPY --from=server /app/server/Admin Admin
