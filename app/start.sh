#!/bin/bash

# set repo
if [ ! $REPO ];
then
  REPO='https://github.com/joomla/joomla-cms.git'
fi;

# set branch
if [ ! $BRANCH ];
then
  BRANCH='4.0-dev'
fi;

# fetch joomla installation if project directory does not exist
if [ ! -d /var/www/joomla-cms ];
then
  git clone $REPO --branch $BRANCH  --depth 1 /var/www/joomla-cms \
  && cd /var/www/joomla-cms \
  && rm -rf administrator/templates/atum/css \
  && rm -rf templates/cassiopeia/css \
  && rm -rf media/ \
  && rm -rf node_modules/ \
  && rm -rf libraries/vendor/
fi;

# execute required tasks for joomla installation if project directory exist
if [ -d /var/www/joomla-cms ];
then
  chown -R j4x:j4x /var/www/joomla-cms \
  && composer install --ignore-platform-reqs \
  && npm ci \
  && chown -R j4x:j4x /var/www/joomla-cms
fi;

service supervisor start
