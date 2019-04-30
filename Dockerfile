FROM 292075781285.dkr.ecr.us-east-1.amazonaws.com/indra:latest

ENV DIRPATH /sw
ENV PYTHONPATH "${DIRPATH}/indra_db:${PYTHONPATH}"
WORKDIR $DIRPATH

# Install psycopg2
RUN git clone https://github.com/psycopg/psycopg2.git && \
    cd psycopg2 && \
    python setup.py build && \
    python setup.py install

# Install pgcopy
RUN git clone https://github.com/pagreene/pgcopy.git && \
    cd pgcopy && \
    python setup.py install

# Install indra_db
RUN git clone https://github.com/indralab/indra_db.git && \
    pip list && \
    echo "PYTHONPATH =" $PYTHONPATH && \
    cd indra_db && \
    git checkout $BUILD_BRANCH && \
    echo "BUILD_BRANCH =" $BUILD_BRANCH && \
    git branch && \
    echo "[indra]" > /root/.config/indra/config.ini

