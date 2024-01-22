FROM postgres:16.1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    vim

RUN echo "host        all        all        all        trust" >> /var/lib/postgresql/data/pg_hba.conf
