socket = require("socket");
loadstring = loadstring or load -- Lua 5.2 compat
host = host or "localhost";
port = port or "8383";
server = assert(socket.bind(host, port));
ack = "\n";
while 1 do
    print("server: waiting for client connection...");
    control = assert(server:accept());
    while 1 do 
        command, emsg = control:receive();
        if emsg == "closed" then
            control:close()
            break
        end
        if command == 'quit' then
            control:close()
            print 'shutting down server'
            return
        end
        assert(command, emsg)
        assert(control:send(ack));
        print(command);
        (loadstring(command))();
    end
end
