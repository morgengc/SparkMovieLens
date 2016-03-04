#~/spark-1.3.1-bin-hadoop2.6/bin/spark-submit --master spark://169.254.206.2:7077 --total-executor-cores 14 --executor-memory 6g server.py 
spark-submit --master local[2] --total-executor-cores 8 --executor-memory 6g server.py
