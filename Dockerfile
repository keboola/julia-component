FROM julia

WORKDIR /code

# Initialize the transformation runner
COPY . /code/
