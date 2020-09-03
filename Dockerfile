FROM python:3.7-slim

RUN mkdir /opt/app
WORKDIR /opt/app

COPY ./app /opt/app

RUN apt-get update
RUN apt-get install \
        --option "Acquire::Retries=3" \
        --no-install-recommends \
        --assume-yes \
        --quiet=2 \
        `# Document extraction and OCRing tools` \
        curl poppler-utils tesseract-ocr tesseract-ocr-eng git-all

RUN pip install --no-cache-dir -r requirements.txt

CMD python server.py

