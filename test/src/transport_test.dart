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

library test.transport;

import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';
import '../../packages/socket/src/transport.dart';
import '../../packages/socket/src/option.dart';
import 'dart:async';

// Test abstract class
class TestTransport extends Transport {}

class Context {
    String test;
}

void main() {

    useHtmlConfiguration();

    test("transport synchronous", () {

        var transport = new TestTransport();
        var context = new Context();
        var option  = new Option(url: "http://localhost:1234/polling");
        
        var flag = false;
        
        transport.syncRequest(context, option, (Context context, Map<String, Map> response) {
            expect(response, isNotNull);
            expect(response["event"], "connection");
            flag = true;
        });        
        
        new Timer(new Duration(milliseconds: 100), expectAsync(() {
            expect(flag, isTrue);            
        }));        
        
    });

    test("transport asynchronous", () {
      
        var transport = new TestTransport();
        var context = new Context();
        var option  = new Option(url: "http://localhost:1234/polling");
        
        var flag_response = false;
        var flag_timeout  = false;
        
        transport.asyncRequest(context, option, 
            (Context context, Map<String, Map> response) {
                expect(response, isNotNull);
                expect(response["event"], "connection");
                flag_response = true;
            },
            (Context context) {
                flag_timeout = true;
            }
        );  
        
        new Timer(new Duration(milliseconds: 100), expectAsync(() {        
            expect(flag_response, isTrue);
            expect(flag_timeout, isFalse);   
        }));
        
    });
    
    test("transport request", () {
        // pass
    });

}