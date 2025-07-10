FROM rocker/r-ver:4.3.1

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev libssl-dev libxml2-dev \
    pandoc wget libgit2-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('renv', repos='https://cloud.r-project.org')"

WORKDIR /app
# (Możesz tu opcjonalnie dodać COPY . /app, jeśli masz już jakiś kod.)
CMD ["bash"]