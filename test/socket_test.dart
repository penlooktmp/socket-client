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

library test.socket;

import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';
import 'package:socket/socket.dart';
import 'dart:async';

void main() {

    useHtmlConfiguration();

    test("socket default constructor", () {

        var socket = new Socket();
        expect(socket.Host, "localhost");
        expect(socket.Port, 80);

    });

    test("socket custom constructor", () {

        var socket = new Socket(host:"127.0.0.1", port: 3000);
        expect(socket.Host, "127.0.0.1");
        expect(socket.Port, 3000);

    });

    test("socket connect", () {

        var socket = new Socket(host: "localhost", port: 1234);
        socket.connect();

        new Timer(new Duration(milliseconds: 100), expectAsync(() {
            expect(socket.Handshake, isNotNull);
            expect(socket.Handshake, hasLength(equals(20)));
        }));
        
    });
    
    test("socket on", () {
        // Pass  
    });
    
    test("socket trigger", () {
        // Pass
    });
    
    test("socket push", () {
        // Converted from Javascript
        // TODO
    }); 
   
    test("socket pull", () {
        // Converted from Javascript
        // TODO
    });
    
    test("socket emit", () {
        // Converted from Javascript
        // TODO
    });    

}