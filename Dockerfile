FROM golang:alpine as build

WORKDIR /build

RUN true \
	&& apk --no-cache add \
		git

RUN true \
	&& go get -u github.com/opendevsecops/go-ssh-decoy

# ---

FROM alpine:latest

WORKDIR /run

COPY --from=build /go/bin/go-ssh-decoy /bin/ssh-decoy

WORKDIR /session

ENTRYPOINT ["/bin/ssh-decoy"]
