# Documentation: http://docs.travis-ci.com/user/languages/julia/
language: julia
os:
  - linux
  - osx
julia:
  - release
  - nightly

before_install:
  - if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
        sudo apt-get install liblapack-dev libblas-dev;
    fi

notifications:
  email: false
