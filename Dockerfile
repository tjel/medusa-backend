FROM node:24.3.0@sha256:4b383ce285ed2556aa05a01c76305405a3fecd410af56e2d47a039c59bdc2f04

WORKDIR /app/backend

COPY package*.json ./

RUN npm install

COPY . .

RUN npm install -g @medusajs/cli@2.8.5

RUN npx medusa build

RUN cd .medusa/server && npm install

CMD ["sh", "-c", "cd .medusa/server && if [ \"$MEDUSA_WORKER_MODE\" = \"server\" ] || [ \"$MEDUSA_WORKER_MODE\" = \"shared\" ]; then npm run predeploy; fi && npm run start"]
