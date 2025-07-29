#!/bin/sh

# SONAR_PROPERTIES="/app/sonarqube/conf/sonar.properties"
# sed --in-place "s/.*sonar.web.host=.*/sonar.web.host=0.0.0.0/g" $SONAR_PROPERTIES

DB_HOSTNAME=$(echo $SCALINGO_POSTGRESQL_URL | cut -d "@" -f2 | cut -d ":" -f1)
DB_PORT=$(echo $SCALINGO_POSTGRESQL_URL | cut -d ":" -f4 | cut -d "/" -f 1)
DB_PASSWORD=$(echo $SCALINGO_POSTGRESQL_URL | cut -d "@" -f1 | cut -d ":" -f3)
DB_NAME=$(echo $SCALINGO_POSTGRESQL_URL | cut -d "?" -f 1 | cut -d "/" -f 4)
# On Scalingo, the database name and the user name are the same
DB_USERNAME=$DB_NAME

# Configure the PostgreSQL database (https://docs.sonarqube.org/latest/setup/environment-variables/).
export SONAR_JDBC_USERNAME="$DB_USERNAME"
export SONAR_JDBC_PASSWORD="$DB_PASSWORD"
export SONAR_JDBC_URL="jdbc:postgresql://${DB_HOSTNAME}:${DB_PORT}/${DB_NAME}"

export SONAR_WEB_HOST=0.0.0.0
export SONAR_WEB_PORT="$PORT"

export SONAR_TELEMETRY_ENABLE="false"

export SONAR_JAVA_PATH="${HOME}/.openjdk/bin/java"

touch /app/sonarqube/logs/es.log
touch /app/sonarqube/logs/ce.log
touch /app/sonarqube/logs/web.log
tail --follow --retry /app/sonarqube/logs/ce.log /app/sonarqube/logs/es.log /app/sonarqube/logs/web.log &

exec /app/sonarqube/bin/linux-x86-64/sonar.sh console
