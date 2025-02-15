#!/bin/bash

# Function to start Jupyter Notebook
start_jupyter() {
    echo "Starting Jupyter Notebook..."
    jupyter notebook --ip=0.0.0.0 --port=4041 --no-browser --NotebookApp.token='' --NotebookApp.password=''
}

# Function to start Spark Shell
start_spark_shell() {
    echo "Starting Spark Shell..."
    spark-shell
}

# Function to start PySpark Shell
start_pyspark_shell() {
    echo "Starting PySpark Shell..."
    unset PYSPARK_DRIVER_PYTHON
    unset PYSPARK_DRIVER_PYTHON_OPTS
    pyspark
}

if [ "$1" = "jupyter" ]; then
    start_jupyter
elif [ "$1" = "spark" ]; then
    start_spark_shell
elif [ "$1" = "pyspark" ]; then
    start_pyspark_shell
else
    echo "Invalid option. Use 'jupyter', 'spark', or 'pyspark'."
    exit 1
fi