FROM rstudio/r-base:4.0-focal
LABEL maintainer="Julien Diot <juliendiot@ut-biomet.org>"

WORKDIR /GWAS-Engine

RUN apt-get update --allow-releaseinfo-change && apt-get install -y \
    libssl-dev \
    gcc-8-base \
    libcurl4 \
    libcurl4-openssl-dev \
    libxml2-dev \
    libz-dev \
    curl \
    pandoc \
    libhiredis-dev \
    libpng-dev

# install dependencies
# install renv package 
ENV RENV_VERSION 0.13.2
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"
# install deps using renv
COPY renv.lock renv.lock
RUN R -e 'renv::init()'


# get application code
COPY . .

CMD ["R"]
