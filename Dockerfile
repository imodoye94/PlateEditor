# Build the static assets
FROM node:20 AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run compil

# Runtime image
FROM node:20-alpine AS runner
WORKDIR /app
COPY --from=builder /usr/src/app/dist ./dist
COPY --from=builder /usr/src/app/Editor.html ./Editor.html
COPY --from=builder /usr/src/app/index.html ./index.html
COPY --from=builder /usr/src/app/examples ./examples
COPY --from=builder /usr/src/app/dependencies ./dependencies
COPY --from=builder /usr/src/app/images ./images
RUN npm install -g serve
EXPOSE 8080
CMD ["serve", "-s", ".", "-l", "8080"]
