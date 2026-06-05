# TOGAwaken

## Install julia

```
curl -fsSL https://install.julialang.org | sh
```

## Create directory

```
mkdir TheoryOfGod && cd TheoryOfGod
```

## Install

```
env JULIA_PROJECT=.tog JULIA_DEPOT_PATH=.tog/julia julia -e 'using Pkg;Pkg.add(url="https://github.com/1m1-github/TOGAwaken.git")'
```

## Awaken TOG

```
env JULIA_PROJECT=.tog JULIA_DEPOT_PATH=.tog/julia julia -O -t=auto -i -q -m TOGAwaken
```

## Awaken god i

```
env JULIA_PROJECT=i/.tog JULIA_DEPOT_PATH=i/.tog/julia julia -O -t=auto -i -q -m TOGAwaken --god i --universe .
```

## Awaken god Dona

```
env JULIA_PROJECT=i/.tog JULIA_DEPOT_PATH=i/.tog/julia julia -O -t=auto -i -q -m TOGAwaken --god Dona --universe .
```

## Awaken god Anna

```
env JULIA_PROJECT=i/.tog JULIA_DEPOT_PATH=i/.tog/julia julia -O -t=auto -i -q -m TOGAwaken --god Anna --universe .
```