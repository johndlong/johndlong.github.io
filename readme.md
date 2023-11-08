dockerized jsonresume
=====================

[![Build Status](https://github.com/johndlong/johndlong.github.io/actions/workflows/ci.yaml/badge.svg)](https://github.com/johndlong/johndlong.github.io/actions/workflows/ci.yaml)

## want to make your own resume from JSON?

Made with http://jsonresume.org

I suggest hosting with [github pages](https://pages.github.com/) since it's easy.

* just fork this repo
* rename to username.github.io
* clone and go!

You need to [install docker](https://docs.docker.com/install/).

# guide

* pick your [theme](https://jsonresume.org/themes/) and edit the Dockerfile with the theme; this uses [elegant-mod](https://github.com/constructorfleet/jsonresume-theme-eloquent-mod)
 * update the `npm` package and the `-t` flag
* fill in the resume.json
* run `docker buildx build --output . -f Dockerfile .`
* push to your github.io page repo

## using GH Actions

Pushes to main should automatically deploy

Thanks
======
Forked from https://github.com/dsayling/resume
