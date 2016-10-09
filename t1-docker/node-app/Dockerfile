FROM node:6

# Create app directory
RUN mkdir -p /opt/app
WORKDIR /opt/app

# Bundle sources and Install app dependencies
COPY . /opt/app/
RUN npm install

EXPOSE 8080
CMD [ "npm", "start" ]

