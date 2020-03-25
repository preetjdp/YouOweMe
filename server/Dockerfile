FROM node:latest

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
COPY package*.json ./

# Install production dependencies.
RUN npm install

# Copy Dist to the container image
COPY . ./

RUN npm run build
# Run the web service on container startup.
CMD ["npm", "run", "start:prod" ]

