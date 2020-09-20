FROM daocloud.io/python:3-onbuild

RUN mkdir /usr/local/download && cd /usr/local/download

RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.15.0/geckodriver-v0.15.0-linux64.tar.gz &&\
    tar xvzf geckodriver-*.tar.gz && rm -f -f /usr/bin/geckodriver && ln -s /usr/local/download/geckodriver /usr/bin/geckodriver

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