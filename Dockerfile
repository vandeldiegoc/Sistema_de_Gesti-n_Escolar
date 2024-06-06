FROM python:3.6-slim

RUN apt update && \
    apt install -y python3 python3-pip python3-setuptools unzip wget python3-gunicorn

RUN groupadd -r web2py && \
    useradd -m -r -g web2py web2py


WORKDIR /home/web2py
USER web2py

RUN rm -rf web2py && \
    wget -c http://web2py.com/examples/static/web2py_src.zip && \
    unzip -o web2py_src.zip && \
    rm -rf applications/ && \
    chmod 777 -R web2py

COPY requirements.txt /requirements.txt
RUN pip3 install --no-cache --upgrade -r /requirements.txt

USER web2py


EXPOSE 8000

CMD /usr/bin/python3 /home/web2py/web2py/anyserver.py -s gunicorn -i 0.0.0.0 -p 8000 -w 3

#CMD  /usr/bin/python /home/web2py/web2py/anyserver.py -s wsgi -i 0.0.0.0 -p 8000
