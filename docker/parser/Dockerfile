FROM golang:1.23-alpine

WORKDIR /app

COPY parser/ .

RUN go mod download
RUN go build -o main .

EXPOSE 8081

CMD ["./main"]
