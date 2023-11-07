FROM node:slim AS app

# We don't need the standalone Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Install Google Chrome Stable and fonts
# Note: this installs the necessary libs to make the browser work with Puppeteer.
RUN apt-get update && apt-get install curl gnupg -y \
  && curl --location --silent https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && apt-get update \
  && apt-get install google-chrome-stable -y --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# FROM alpine:edge

# # Installs latest Chromium (77) package.
# RUN apk add --no-cache \
#       chromium \
#       nss \
#       freetype \
#       freetype-dev \
#       harfbuzz \
#       ca-certificates \
#       ttf-freefont \
#       nodejs \
#       npm \
#       yarn 


# # Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
# ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# # Puppeteer v21.5.0 works with Chromium 86.
# RUN yarn add puppeteer@21.5.0

# # Add user so we don't need --no-sandbox.
# RUN addgroup -S pptruser && adduser -S -g pptruser pptruser \
#     && mkdir -p /home/pptruser/Downloads /app \
#     && chown -R pptruser:pptruser /home/pptruser \
#     && chown -R pptruser:pptruser /app

RUN npm install -g resumed

WORKDIR /build/
COPY ./ /build/

RUN npm install -g --save jsonresume-theme-eloquent-mod

# Run everything after as non-privileged user.
RUN resumed render resume.json -o index.html -t jsonresume-theme-eloquent-mod

FROM scratch AS export
COPY --from=app /build/index.html .
