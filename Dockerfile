FROM node:slim AS app

RUN npm install -g resumed jsonresume-theme-eloquent-mod

WORKDIR /build/
COPY ./ /build/

RUN resumed render resume.json -o index.html -t jsonresume-theme-eloquent-mod

FROM scratch AS export
COPY --from=app /build/index.html .
