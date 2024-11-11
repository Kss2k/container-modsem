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
    gausssuppression \
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

# Set up a non-root user (optional but recommended)
ARG USERNAME=rstudio
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

# Set default command
CMD ["bash"]
