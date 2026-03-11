FROM node:20-alpine

ENV NODE_ENV=production

# Passage immédiat en utilisateur non-root
USER node


WORKDIR /home/node/app

# Copie des manifestes avec bonnes permissions
COPY --chown=node:node package*.json ./



# Installation propre (sans devDependencies) + nettoyage cache
RUN npm ci --omit=dev && npm cache clean --force
RUN npm update "zlib:1.3.2-r0"


# Copie du code source avec bonnes permissions
COPY --chown=node:node . .

EXPOSE 3000
CMD ["node", "server.js"]
