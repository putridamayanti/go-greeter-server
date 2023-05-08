FROM golang:buster as build

WORKDIR /go/src/greeter-server

RUN curl -o main.go https://github.com/putridamayanti/go-greeter-server/blob/main/main.go
RUN go mod init greeter-server
RUN go mod tidy
RUN go build -o /greeter-server main.go

FROM gcr.io/distroless/base-debian10

COPY --from=build /greeter-server /

EXPOSE 50051

CMD ["/greeter-server"]