# Penlook Socket
Real-time library for Go based on Long-polling

[![Build Status](https://travis-ci.org/penlook/socket.svg?branch=master)](https://travis-ci.org/penlook/socket) [![GoDoc](https://godoc.org/github.com/penlook/socket?status.png)](https://godoc.org/github.com/penlook/socket) [![Software License](https://img.shields.io/badge/license-GNU-blue.svg?style=flat)](LICENSE.md) [![Author](http://img.shields.io/badge/author-penlook-red.svg?style=flat)](https://github.com/penlook)

# Compatibility
Long-polling request support all major browsers
<div><a href="https://github.com/penlook/socket"><img src="https://raw.githubusercontent.com/alrra/browser-logos/master/main-desktop.png" align="left" height="50"></a></div>

<br></br>
<br></br>

# Roadmap

- Support Web Socket for HTML5 browser compatibility
- Implement binary transfer feature
- Fix bug

# Example

Server - Go
```go
import (
	. "github.com/penlook/socket"
)

socket := Socket {
	Port: 3000,
	Token: "acbz@3345123124567",
	Interval: 60,
}

socket.Initialize()

socket.On("connection", func(client Client) {
	client.On("ping", func(data Json) {
		ftm.Println(data); // Ping from client
		client.emit("pong", Json {
			data: "Pong from server"
		})
	})
})

socket.Listen()
```

Client (Dart - Implementing)
```dart
Socket socket = new Socket(3000);

socket.on("ping", (Map data) {
	print(data); // Pong from server
});

socket.emit("ping", {
	"data" : "Ping from client"
})

```