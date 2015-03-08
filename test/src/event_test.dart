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

library test.event;

import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';
import 'package:socket/socket.dart';

// Mockup to test abstract class
class TestEvent extends Event {  
    TestEvent() {
        this.event = new List();
    }
}

void main() {

    useHtmlConfiguration();    
        
    test("event node", () {        
        
        EventNode node = new EventNode("abc", (Object abc) {
            abc.toString();
        });
        
        expect(node.Name, "abc");
        expect(node.Callback(new Object()), equals((Object abc) {}(new Object())));
                
    });
    
    test("event - on", () {             
         
        TestEvent event = new TestEvent();
      
        event.on("connection", (Object abc) {
            abc.toString();
        });
         
        Iterator listEvent = event.event.iterator;
        var len = 0;
         
        while (listEvent.moveNext()) {
             EventNode firstNode = listEvent.current;
             len ++;
             expect(firstNode.Name, "connection");
             expect(firstNode.Callback(new Object()), equals((Object abc) {}(new Object())));
        }
         
        // Make sure linklist works properly
        expect(len, 1);
         
    });
    
    test("event - trigger", () {
        
        TestEvent event = new TestEvent();
        
        var pass = false;
        
        event.on("connection", (Map<String, Map> data) {
            expect(data["key1"].toString(), "value1");
            expect(data["key2"].toString(), "value2");
            
            // Make sure callback works properly
            pass = true;
        });
        
        event.trigger("connection", {
            "key1" : "value1",
            "key2" : "value2"
        });
        
        // Callback works fine !
        expect(pass, isTrue);
        
    });
    
    
}