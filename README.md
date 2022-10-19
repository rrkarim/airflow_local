# Run dag with airflow server/scheduler running inside the docker

To run your dag do this:
1. Build (`docker build -t run_local_airflow .`)
2. Run container with mount and port forward: 
```bash
docker run -p $HOST_PORT:8080 \
    -v $HOST_DAGS_PATH:/home/user0/dags \
    -it run_local_airflow
    OPTIONAL[requirements.txt] 
    # provide this to pip install additional modules for your dag
    # be sure that requirements.txt is in $HOST_DAGS_PATH/
```
3. Go to `localhost:$HOST_PORT` (user_name and pass is `user`)
4. You will see your dags there.
