FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .

# Build process, output will go to app/build
RUN npm run build

FROM nginx
EXPOSE 3000
# Copy default.conf file to change default port nginx listens on
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# Copy assets across from builder phase
COPY --from=0 /app/build /usr/share/nginx/html
