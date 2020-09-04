#FROM python:3.7-slim

#FROM tiangolo/uwsgi-nginx-flask:python3.8
#
##RUN mkdir /src
#WORKDIR /src
#
#COPY ./src /src
#
#RUN apt-get update
#RUN apt-get install \
#        --option "Acquire::Retries=3" \
#        --no-install-recommends \
#        --assume-yes \
#        --quiet=2 \
#        `# Document extraction and OCRing tools` \
#        curl poppler-utils tesseract-ocr tesseract-ocr-eng git-all
#
#RUN pip install --no-cache-dir -r requirements.txt
#
#CMD python server.py
#
#


FROM python:3.7

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        libatlas-base-dev gfortran nginx supervisor

RUN apt-get install \
        --option "Acquire::Retries=3" \
        --no-install-recommends \
        --assume-yes \
        --quiet=2 \
        `# Document extraction and OCRing tools` \
        curl poppler-utils tesseract-ocr tesseract-ocr-eng git-all


RUN pip install uwsgi

COPY ./requirements.txt /project/requirements.txt

RUN pip install -r /project/requirements.txt

RUN useradd --no-create-home nginx

RUN rm /etc/nginx/sites-enabled/default
RUN rm -r /root/.cache

COPY server-conf/nginx.conf /etc/nginx/
COPY server-conf/flask-site-nginx.conf /etc/nginx/conf.d/
COPY server-conf/uwsgi.ini /etc/uwsgi/
COPY server-conf/supervisord.conf /etc/supervisor/

COPY src /project/src

WORKDIR /project

CMD ["/usr/bin/supervisord"]







#
#FROM python:3.7
#
#RUN apt-get update
#RUN apt-get install -y --no-install-recommends \
#        libatlas-base-dev gfortran nginx supervisor
#RUN apt-get install \
#        --option "Acquire::Retries=3" \
#        --no-install-recommends \
#        --assume-yes \
#        --quiet=2 \
#        `# Document extraction and OCRing tools` \
#        curl poppler-utils tesseract-ocr tesseract-ocr-eng git-all
#
#RUN pip install uwsgi
#
#COPY ./requirements.txt /app/requirements.txt
#
#RUN pip install -r /app/requirements.txt
#
#RUN useradd --no-create-home nginx
#
#RUN rm /etc/nginx/sites-enabled/default
#RUN rm -r /root/.cache
#
#COPY server-conf/nginx.conf /etc/nginx/
#COPY server-conf/flask-site-nginx.conf /etc/nginx/conf.d/
#COPY server-conf/uwsgi.ini /etc/uwsgi/
#COPY server-conf/supervisord.conf /etc/supervisor/
#
#COPY src /opt/app
#
#WORKDIR /opt
#
#CMD ["/usr/bin/supervisord"]
