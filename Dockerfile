FROM spark:3.5.4-scala2.12-java17-ubuntu

USER root

RUN set -ex; \
    apt-get update; \
    apt-get install -y python3 python3-pip; \
    rm -rf /var/lib/apt/lists/*

# Following code is added by @engnilesh for running spark with Python API
RUN pip3 install --no-cache-dir pyspark==3.5.4 jupyter findspark

# Set up a non-root user
ARG USERNAME=sparkuser
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Set ownership for Spark directories
RUN mkdir -p /home/spark \
    && chown -R $USER_UID:$USER_GID /home/spark

# Create directories for logs and event logs
RUN mkdir -p /home/spark/logs \
    && mkdir -p /home/spark/event_logs \
    && chown -R $USER_UID:$USER_GID /home/spark/event_logs \
    && chown -R $USER_UID:$USER_GID /home/spark/logs

# Add the entrypoint script
COPY entrypoint.sh /home/spark/entrypoint.sh
RUN chmod +x /home/spark/entrypoint.sh

# Switch to non-root user
USER $USERNAME

# Set workdir and create application and data directories
RUN mkdir -p /home/$USERNAME/app \
    && mkdir -p /home/$USERNAME/data
WORKDIR /home/$USERNAME/app

# Expose necessary ports for Spark UI and Jupyter 
EXPOSE 4040 4041

ENTRYPOINT ["/home/spark/entrypoint.sh"]

CMD ["jupyter"]