FROM gcr.io/google.com/cloudsdktool/cloud-sdk


RUN adduser user0 --disabled-password --gecos "First Last,RoomNumber,WorkPhone,HomePhone"
USER user0
WORKDIR /home/user0
ENV PATH="/home/user0/.local/bin:${PATH}"

RUN export AIRFLOW_HOME=~/airflow

COPY --chown=user0:user0 run_airflow.sh .

RUN export AIRFLOW_VERSION=2.3.2 && \
    export PYTHON_VERSION="$(python3 --version | cut -d " " -f 2 | cut -d "." -f 1-2)" && \
    export CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt" && \
    pip install --user "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"

RUN pip install wurlitzer numpy pandas seaborn dask scikit-learn google-cloud \
      google-cloud-bigtable google-cloud-storage google-cloud-bigquery \
      google-cloud-bigquery-storage cloud-tpu-client pyarrow fastparquet gcsfs

ENV PATH="/home/user0/.local/bin:${PATH}"

ENV AIRFLOW__SCHEDULER__MIN_FILE_PROCESS_INTERVAL=2
ENV AIRFLOW__SCHEDULER__DAG_DIR_LIST_INTERVAL=10
ENV AIRFLOW__CORE__LOAD_EXAMPLES=False
ENV AIRFLOW__CORE__DAGS_FOLDER=/home/user0/dags

ENTRYPOINT ["bash", "./run_airflow.sh"]
