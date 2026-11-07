FROM python:3.12-slim

RUN pip install --no-cache-dir --retries 10 --timeout 120 --index-url https://pypi.org/simple ansible-core==2.21.6 boto3 botocore

RUN python -c "import urllib.request; urllib.request.urlretrieve('https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb', '/tmp/session-manager-plugin.deb')" \
    && dpkg -i /tmp/session-manager-plugin.deb \
    && rm /tmp/session-manager-plugin.deb

RUN ansible-galaxy collection install amazon.aws

WORKDIR /workspace

CMD ["bash"]
