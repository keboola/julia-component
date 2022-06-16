[![Build Status](https://travis-ci.com/keboola/julia-component.svg?branch=master)](https://travis-ci.com/keboola/julia-component)

Helper component which implements the [common component interface](https://developers.keboola.com/extend/common-interface/) 
provided by Keboola Connection [Docker Runnner](https://github.com/keboola/docker-bundle).

## Installation
Install the package:

```
using Pkg
Pkg.add(PackageSpec(url="https://github.com/keboola/julia-component", rev="master"))
```

## Usage
To use the package:
```
using KeboolaConnectionComponent
config = KeboolaConnectionComponent.config()
println(config.parameters)

```

## Development
To run the tests locally do:

```
docker build -t julia-component .
docker run julia-component julia -e "using Pkg; Pkg.activate(\"/code\"); Pkg.update(); Pkg.build(); Pkg.test()"
```

The `Pkg.update()` command is necessary to match minor libraries version with those in the docker image.

## License

MIT licensed, see [LICENSE](./LICENSE) file.
