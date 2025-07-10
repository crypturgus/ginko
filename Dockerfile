FROM rocker/r-ver:4.3.1

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    pandoc \
    wget \
    automake \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ----------------------------
# Instalacja dependencies (KOLEJNOŚĆ MA ZNACZENIE!)
# ----------------------------

RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/glue/glue_1.6.2.tar.gz', repos=NULL, type='source')"
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/ellipsis/ellipsis_0.3.2.tar.gz', repos=NULL, type='source')"
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/rlang/rlang_1.0.2.tar.gz', repos=NULL, type='source')"
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/lifecycle/lifecycle_1.0.1.tar.gz', repos=NULL, type='source')"
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/magrittr/magrittr_2.0.3.tar.gz', repos=NULL, type='source')"
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/fansi/fansi_1.0.3.tar.gz', repos=NULL, type='source')"
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/pillar/pillar_1.7.0.tar.gz', repos=NULL, type='source')"
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/pkgconfig/pkgconfig_2.0.3.tar.gz', repos=NULL, type='source')"
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/vctrs/vctrs_0.4.1.tar.gz', repos=NULL, type='source')"
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/tidyselect/tidyselect_1.1.2.tar.gz', repos=NULL, type='source')"
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/tibble/tibble_3.1.7.tar.gz', repos=NULL, type='source')"
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/purrr/purrr_0.3.4.tar.gz', repos=NULL, type='source')"
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/lazyeval/lazyeval_0.2.2.tar.gz', repos=NULL, type='source')"

# Teraz dopiero główne paczki
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/dplyr/dplyr_1.0.9.tar.gz', repos=NULL, type='source')"
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/tidyr/tidyr_1.2.0.tar.gz', repos=NULL, type='source')"
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/utile.tools/utile.tools_0.2.7.tar.gz', repos=NULL, type='source')"

# Pozostałe paczki (możesz dodać wersje jeśli chcesz super stabilności)
RUN Rscript -e "install.packages(c('shiny', 'DT', 'stringr', 'readr'), repos='https://cloud.r-project.org')"

WORKDIR /app
COPY app/ /app/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/app', host='0.0.0.0', port=3838)"]
