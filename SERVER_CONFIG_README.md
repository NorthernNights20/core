# Server Configuration

## File: server_config.json

This file contains the server connection configuration for the game client.

### Configuration Options

- **server_ip**: The IP address of the game server (default: "127.0.0.1" for localhost)
- **server_port**: The port number the server is listening on (default: 43210)

### Usage

1. Copy `server_config.json.template` in a `server_config.json` file
2. Edit the `server_config.json` file with your desired server settings
2. Save the file
3. Launch the game client

### Example Configurations

**Local Server (default):**
```json
{
	"server_ip": "127.0.0.1",
	"server_port": 43210
}
```

**Remote Server:**
```json
{
	"server_ip": "192.168.1.100",
	"server_port": 43210
}
```

**Custom Port:**
```json
{
	"server_ip": "127.0.0.1",
	"server_port": 12345
}
```

### Notes

- If the config file is missing or invalid, the game will use default values (127.0.0.1:43210)
- Changes to this file require restarting the game client to take effect
- Make sure the IP address and port match your server configuration
