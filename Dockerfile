FROM node
WORKDIR /app
ENV NODE_PATH=.
COPY ./build/ .
COPY package.json .
COPY ./mdb.sh .
RUN npm install --silent
EXPOSE 8080
CMD [./mdb.sh]