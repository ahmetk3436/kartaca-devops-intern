#!/bin/bash

# initiate replica set
mongo <<EOF
var config = {
    "_id": "dbrs",
    "version": 1,
    "members": [
        {
            "_id": 1,
            "host": "mongo1:27017",
            "priority": 3
        },
        {
            "_id": 2,
            "host": "mongo2:27017",
            "priority": 2
        },
        {
            "_id": 3,
            "host": "mongo3:27017",
            "priority": 1
        }
    ]
};
rs.initiate(config, { force: true });
rs.status();
EOF

# enable authentication
mongo admin <<EOF
use admin
db.createUser({user:"root", pwd:"root", roles:[{role:"root", db:"admin"}]})
EOF

# create stajdb database
mongo -u admin -p password <<EOF
use stajdb
db.createCollection("iller")
db.createCollection("ulkeler")
EOF

# add sample data to iler collection
mongo -u admin -p password <<EOF
use stajdb
for (i = 1; i <= 10; i++) {
    db.iller.insert({il_adi: "il" + i})
}
EOF

# add sample data to ulkeler collection
mongo -u admin -p password <<EOF
use stajdb
for (i = 1; i <= 10; i++) {
    db.ulkeler.insert({ulke_adi: "ulke" + i})
}
EOF
