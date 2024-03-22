FROM node
WORKDIR /app
COPY *.json .
COPY *.js .
COPY *.png .
COPY *.ts .
COPY src/ ./src/

COPY .env .

RUN npm install

RUN npx prisma generate

RUN npx prisma migrate deploy

RUN npx nx serve api

RUN npx prisma db seed


EXPOSE 3000


# Command to start the application
# CMD [ "npm", "run", "start" ]
CMD ["npm", "ci", "&&", "npx", "prisma", "migrate", "deploy", "&&", "node", "dist/api/main.js"]
