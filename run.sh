#!/bin/bash

dropdb -U postgres ksi_erc_development
createdb -U postgres ksi_erc_development
rake db:migrate
psql -U postgres ksi_erc_development < ~/Projekty/ksi-erc-intra/ksi_erc.sql
