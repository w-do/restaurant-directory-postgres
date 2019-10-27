FROM postgres:alpine
ENV POSTGRES_DB restaurant
ENV POSTGRES_PASSWORD Password1!

COPY ./init-db.sql /docker-entrypoint-initdb.d/
