FROM node:alpine
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . . 
RUN npm run build 
#/app/build will contain our build folder that needs to be copied over in run phase

FROM nginx 
#from statement is a signal that first phase is over
EXPOSE 80 
#tells Elastic beanstalk which port to expose

# COPY --from=builder /app/build /usr/share/nginx/html
COPY --from=0 /app/build usr/share/nginx/html
#default command of nginx is start - so we dont need to start it ourselves
#use unnamed builder
