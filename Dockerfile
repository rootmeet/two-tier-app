# Python official runtime
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install required plugins
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# copy the requirement file into container
COPY requirement.txt .

# install plug-ins
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirments.txt

# copy application code
COPY . .

#Specifiy the command to run your application
CMD ["python", "app.py"]
