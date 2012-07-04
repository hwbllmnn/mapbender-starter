#!/bin/sh

# Store current directory away
start=`pwd`

# Clone starter and Mapbender
git clone git://github.com/mapbender/mapbender-starter.git mapbender-starter
cd mapbender-starter
git submodule update --init --recursive

# Get extra deps needed by MapQuery
cd application/mapbender/src/Mapbender/CoreBundle/Resources/public/mapquery/lib
./getdeps.sh

cd "$start/mapbender-starter/application"

# mapbender does not ship with a default parameters ini, but it provides
# a template that can be used as one. So do that
cp app/config/parameters.ini.dist app/config/parameters.ini

# Install assets
app/console assets:install --symlink web

# Create SQLite database
app/console doctrine:database:create
app/console doctrine:schema:create

