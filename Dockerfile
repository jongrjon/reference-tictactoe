FROM node
WORKDIR /app
ENV NODE_PATH .
ADD ./build/ .
ADD package.json .
ADD mdb.sh .
RUN npm install --silent
EXPOSE 80
CMD ["/app/mdb.sh"]