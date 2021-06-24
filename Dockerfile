# Start from the latest golang base image
FROM golang:alpine3.13

# Set the Current Working Directory inside the container
WORKDIR  $GOPATH/src/github.com/buxtronix/am2pushbullet
# Copy the source from the current directory to the Working Directory inside the container
COPY . .
# Go mod, get and install
RUN go mod init && go get -d -v ./... && go mod download && go build -o main .
# # Expose port 8080 to the outside world
# EXPOSE 8080
ENV API_KEY ""
ENV LISTEN_PORT ""
# Command to run the executable
CMD ./main -api_key $API_KEY -port $LISTEN_PORT