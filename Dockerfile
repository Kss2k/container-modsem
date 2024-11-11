FROM rocker/r-ver:4.4.1

LABEL org.opencontainers.image.source="https://github.com/kss2k/container-modsem"
LABEL org.opencontainers.image.description="Container for running modsem tests"
LABEL org.opencontainers.image.licenses="MIT"

# Install system dependencies including Cairo
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    sudo \
    pandoc \
    qpdf \
    libcairo2-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install R packages from CRAN
RUN install2.r --error \
    dplyr \
    GaussSuppression \
    httpgd \
    languageserver \
    modsem \
    mirt \
    devtools \
    roxygen2 \
    rmarkdown \
    markdown \
    pkgdown \
    usethis \
    rcmdcheck \
    rversions \
    urlchecker \
    tinytex \
    sirt \
    nonnest2

# Install TinyTeX (LaTeX distribution for R Markdown)
RUN Rscript -e "tinytex::install_tinytex()"
