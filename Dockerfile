FROM rocker/r-base:latest

LABEL org.opencontainers.image.source=https://github.com/kss2k/container-modsem
LABEL org.opencontainers.image.description="Container for running modsem tests"
LABEL org.opencontainers.image.licenses=MIT

# keep testing only – drop sid lines
RUN sed -i '/sid/d' /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends \
    git sudo pandoc qpdf \
    libcairo2-dev libfreetype6-dev libpng-dev \
    libtiff5-dev libjpeg-dev libcurl4-openssl-dev libssl-dev \
    libharfbuzz-dev libfribidi-dev \
    libfontconfig1-dev libpango1.0-dev libxml2-dev libtiff-dev \
 && rm -rf /var/lib/apt/lists/*

# Install R packages from CRAN
RUN echo 'install.packages(c(' >> install_packages.R && \
  echo '"devtools", "dplyr", "httpgd", "languageserver", "plotly",' >> install_packages.R && \
  echo '"modsem", "mirt", "roxygen2", "fastQHQuad", "rmarkdown", "rbenchmark",' >> install_packages.R && \
  echo '"markdown", "pkgdown", "usethis", "rcmdcheck", "Deriv", ' >> install_packages.R && \
  echo '"rversions", "urlchecker", "tinytex", "sirt", "nonnest2"' >> install_packages.R && \
  echo '))' >> install_packages.R
RUN Rscript install_packages.R
