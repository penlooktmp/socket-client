/**
 * Penlook Project
 *
 * Copyright (c) 2015 Penlook Development Team
 *
 * --------------------------------------------------------------------
 *
 * This program is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Affero General Public License
 * as published by the Free Software Foundation, either version 3
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public
 * License along with this program.
 * If not, see <http://www.gnu.org/licenses/>.
 *
 * --------------------------------------------------------------------
 *
 * Authors:
 *     Loi Nguyen       <loint@penlook.com>
 *     Nam Vo           <namvh@penlook.com>
 */

library socket;

import "src/transport.dart";
import "src/event.dart";
import "src/option.dart";

export "src/transport.dart";
export "src/event.dart";
export "src/option.dart";

/**
 * Socket
 *
 * @category   Socket
 * @package    Service
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
class Socket extends Transport with Event {

    /**
     * Socket protocol
     *
     * @var string http | https
     */
    String protocol;
    String get Protocol => protocol;
    set Protocol(String protocol_) => protocol = protocol_;

    /**
     * Host name
     *
     * @var string
     */
    String host;
    String get Host => host;
    set Host(String host_) => host = host_;

    /**
     * Server port
     *
     * @var int
     */
    int port;
    int get Port => port;
    set Port(int port_) => port = port_;

    /**
     * Socket server url
     *
     * @var string
     */
    String url;
    String get Url => url;
    set Url(String url_) => url = url_;

    /**
     * Handshake string
     *
     * @var string (hash)
     */
    String handshake;
    String get Handshake => handshake;
    set Handshake(String hanshake_) => handshake = hanshake_;
    
    /**
     * Socket contructor
     *
     * @param string protocol [default=http] 
     * @param string localhost [default=localhost]
     * @param int    port [default=80]
     */
    Socket({
        String protocol : "http",
        String host : "localhost",
        int port: 80
    }) {
        this.host = host;
        this.port = port;
        this.protocol = "http";
        this.url = protocol + "://" + host + ":" + port.toString();
        this.event = new List();
    }

    /**
     * Establish new connection to server
     *
     */
    void connect() {
          
          var option = new Option(
                               url: this.Url + "/polling", 
                               async: false
                           );
          
          this.sendRequest(this, option, (Socket socket, Map<String, Map> response) {
              print(response);
              if (response["event"] == "connection") {
                  Map data = response["data"];
                  socket.Handshake = data["handshake"];
              }
          });
          
    }
    
    void disconnect() {
        // TODO
    }
    
    bool isConnected() {      
        // TODO
        return true;
    }

    void pull() {      
      
        if (this.handshake != null) {  
            this.sendRequest (
                this,
                new Option(
                    url: this.Url + "/polling" + this.handshake,
                    async: false
                ),                
                // Response callback
                (Object context, Map<String, Map> response) {
                    Socket socket = context as Socket;                         
                    socket.trigger(response["event"].toString(), response["data"]);
                    
                    // Create new pull
                    socket.pull();
                },
                // Timeout callback
                timeout_callback : (Object context) {
                    Socket socket = context as Socket;
                    
                    // Create new pull
                    socket.pull(); 
                }
            );
        }
        
    }
    
    @override void emit(String event, Map<String, Map> data) {
      
        this.push(
            {
                "event" : event,
                "data"  : data
            },
            (Object context, Map<String, Map> response) {
              
                // Socket type casting  
                Socket socket = context as Socket;
                socket.log("Done");
                                                   
            }
        );
        
    }
    
    void push(Map<String, Map> event_data, Function callback(Object context, Map<String, Map> response)) {      
        
        if (this.handshake != null) {          
            this.sendRequest(
                this,
                new Option(
                    method: "POST",
                    url: this.Url + "/polling" + this.handshake,
                    data: event_data,
                    async: false
                ), 
                callback
            );
        }
        
    }
    
    void log(String message) {
        print(message);            
    }
    
    
    
}
