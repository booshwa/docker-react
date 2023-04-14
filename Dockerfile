# Build phase (first phase)
# using the "as" command to name the phase 
FROM node:18-alpine as builder 

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

# run the build command but not using CMD
RUN npm run build
# outputs to /app/build

# Run phase (second phase)
FROM nginx
# copy from the builder /app/build folder to /usr/share/nginx/html
# => /usr/share/nginx/html is the default nginx folder
COPY --from=builder /app/build /usr/share/nginx/html