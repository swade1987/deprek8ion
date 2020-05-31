FROM instrumenta/conftest:v0.18.2

LABEL MAINTAINER Steven Wade <steven@stevenwade.co.uk>

COPY policies/* /policies/

ENTRYPOINT ["/conftest", "test", "-p", "/policies"]
