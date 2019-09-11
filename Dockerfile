FROM julia

WORKDIR /code

# install packages "globally"
ENV JULIA_DEPOT_PATH /opt/julia-packages/
RUN julia -e 'using Pkg; Pkg.add("CSV"); Pkg.add("JSON");'

COPY . /code/
