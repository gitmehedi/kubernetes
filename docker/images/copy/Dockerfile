FROM ubuntu:18.04

RUN apt-get update -y && apt-get install python -y
COPY test.py /opt/
WORKDIR /opt
CMD ["python","test.py"]
