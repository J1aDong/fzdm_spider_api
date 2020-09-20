FROM daocloud.io/python:3-onbuild

RUN mkdir /usr/local/download && cd /usr/local/download

RUN apt-get install yum

RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.15.0/geckodriver-v0.15.0-linux64.tar.gz &&\
    tar xvzf geckodriver-*.tar.gz && rm -f -f /usr/bin/geckodriver && ln -s /usr/local/download/geckodriver /usr/bin/geckodriver

RUN wget http://www.rpmfind.net/linux/centos/6.10/os/x86_64/Packages/firefox-52.8.0-1.el6.centos.x86_64.rpm &&\
    yum install -y firefox-52.8.0-1.el6.centos.x86_64.rpm


# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV NAME FZDM

# Run app.py when the container launches
CMD ["python", "app.py"]