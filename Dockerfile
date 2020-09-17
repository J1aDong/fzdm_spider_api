FROM ubuntu:18.04
RUN  apt-get update
RUN  apt-get upgrade -y
# Install python3
RUN  apt-get install -y python3
# Install pip
RUN apt-get install -y wget vim
RUN wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py
RUN python3 /tmp/get-pip.py
RUN pip install --upgrade pip
#Install other libs
#RUN pip install -U flask

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