FROM rocker/r2u:24.04
LABEL org.opencontainers.image.source=https://github.com/kss2k/container-modsem
LABEL org.opencontainers.image.description="Container for running modsem tests"
LABEL org.opencontainers.image.licenses=MIT

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        micro \
        r-cran-dplyr \
        r-cran-gausssuppression \
        r-cran-httpgd \
        r-cran-languageserver \
        r-cran-modsem \
        r-cran-rcmdcheck \
        r-cran-devtools \
        r-cran-roxygen2 \
        r-cran-rmarkdown \
        sudo \
        r-cran-pkgdown \
        r-cran-usethis \
        pandoc \
        r-cran-usethis \
        r-cran-pkgdown \
        r-cran-rcmdcheck \
        r-cran-rversions \
        r-cran-urlchecker \
        r-cran-tinytex \
        qpdf \ 
    && apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/*


