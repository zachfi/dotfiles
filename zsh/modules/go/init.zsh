if [[ -d "${HOME}/go" ]]; then
  export GOPATH=~/go
  export PATH=$PATH:${GOPATH}/bin
  export GOFLAGS="-tags=unit,integration"
fi
