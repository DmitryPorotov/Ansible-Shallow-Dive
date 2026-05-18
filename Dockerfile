FROM debian:11
ARG BUILD_DIR
ENV BUILD_DIR=${BUILD_DIR}
RUN apt-get update && \ 
    DEBIAN_FRONTEND=noninteractive \ 
    apt-get install -y  darkslide  \
                        weasyprint \
                        codespell  \ 
                && \
    apt clean   && \
    rm -rf /var/cache/apt/*
WORKDIR "/${BUILD_DIR}"
CMD [ "./generate.sh", "-b" ]
