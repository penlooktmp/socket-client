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

library test.option;

import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';
import 'package:socket/socket.dart';

void main() {

    useHtmlConfiguration();

    test("option default constructor", () {

        // Test default constructor
        var option = new Option();
        expect(option.Method, "GET");
        expect(option.Url, "");
        expect(option.Data, {});
        expect(option.Timeout, 60);
        expect(option.Async, isTrue);

    });

    test("option custom constructor", () {

        // Test custom constructor
        var option = new Option(
             method: "POST",
             url:"/abc",
             data:  {
                "key":"value"
             },
             timeout: 20,
             async: false
         );

        expect(option.Method, "POST");
        expect(option.Url, "/abc");
        expect(option.Data, {"key" : "value"});
        expect(option.Timeout, 20);
        expect(option.Async, isFalse);

    });

    test("option setter - gettter", () {

        var option = new Option();
        expect(option.Method, "GET");
        option.Method = "POST";
        expect(option.Method, "POST");

        expect("", option.Url);
        option.Url = "/abc";
        expect(option.Url, "/abc");

        expect(option.Data, {});
        option.Data = {"key" : "value"};
        expect(option.Data, {"key" : "value"});

        expect(option.Timeout, 60);
        option.Timeout = 20;
        expect(option.Timeout, 20);

        expect(option.Async, isTrue);
        option.Async = false;
        expect(option.Async, isFalse);

    });

}
