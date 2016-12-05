FROM node
WORKDIR /app
ENV NODE_PATH=.
COPY ./build/ .
COPY package.json .
RUN npm install --silent
EXPOSE 8080
CMD [set -e
	sleep 10
	npm run migratedb
	node run.js
	exit 0
]