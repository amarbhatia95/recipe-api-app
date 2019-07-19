# Use python 3.7 alpine which is lightweight and fast
# First line is FROM:{name_of_image}
FROM python:3.7-alpine

# This line is optional but it's always good to know the maintainer
MAINTAINER Amar Bhatia

# Next we need to set the python unbuffered environment variable
# This tells python to run in unbuffered mode, which is needed for docker
ENV PYTHONUNBUFFERED 1

# Install our dependences in a requirements.txt list
# Copy requirements file from local to docker image building
COPY ./requirements.txt /requirements.txt

# Takes the requirements file and installs it using pip to docker image
RUN pip install -r /requirements.txt

# Make directory within docker image that we can use to store app source code
# Create empty directory on docker image called app
# Change to that as the working directory
# Copy our local machine app folder to the app folder on our image
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Create user that will run our application using adduser
# Finally, switch to that user
# This is secure if you get hacked they only have the user profile
RUN adduser -D user
USER user
