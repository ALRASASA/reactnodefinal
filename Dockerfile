# Stage 1: Build the frontend
FROM node:18 as frontend-build
WORKDIR /app/frontend
COPY frontend/package.json frontend/package-lock.json ./
RUN npm install

COPY frontend ./
RUN npm run build

# Stage 2: Build the backend
FROM node:18 as backend-build
WORKDIR /app/backend
COPY backend/package.json backend/package-lock.json ./
RUN npm install
COPY backend ./

# Stage 3: Create the production image
FROM node:18
WORKDIR /app
COPY --from=frontend-build /app/frontend/build ./frontend/build
COPY --from=backend-build /app/backend ./backend
EXPOSE 3001
WORKDIR /app/backend
CMD ["node", "app.js"]

