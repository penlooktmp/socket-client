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

library socket.event;

class EventNode {
  
    String name;
    set Name(String name_) => name = name_;
    get Name => name;       
    
    Function callback;
    set Callback(Function callback_) => callback = callback_;
    get Callback => callback;
      
    EventNode(String name, Function callback) {
        this.name = name;
        this.callback = callback;
    }
    
}

abstract class Event {
        
    List<EventNode> event;
    
    void on(String event, Function callback) {
        this.event.add(new EventNode(event, callback));
    }
    
    void trigger(String event, Map<String, Map> data) {                  
        Iterator listEvent = this.event.iterator;
        
        while (listEvent.moveNext()) {
            EventNode node = listEvent.current as EventNode;
            if (node.Name == event) {
                node.Callback(data);
            }
        } 
    }
        
    void emit(String event, Map<String, Map> data) {}    
    
}
