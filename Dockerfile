FROM node
WORKDIR /app
ENV NODE_PATH=.s
ADD ./build/ .
ADD package.json .
ADD mdb.sh .
RUN npm install --silent
EXPOSE 3000
CMD ["/app/mdb.sh"]