#!/bin/bash

pg_hostname=alices_rabbit_dev
export PGPASSWORD=postgres
if psql -U postgres -lqt | cut -d \| -f 1 | grep -qw alices_rabbit_dev; then
    echo "Database already exists, processing migration..."
    mix ecto.migrate
else
    echo "Creation of the $pg_hostname database"
    mix ecto.create
    echo "Database successfully created, processing migration..."
    mix ecto.migrate
fi

mix phx.server