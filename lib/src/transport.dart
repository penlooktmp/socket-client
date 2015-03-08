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

library socket.transport;

import "dart:html";
import "dart:convert";
import 'option.dart';

/**
 * Transport
 *
 * @category   Transport
 * @package    Service
 * @copyright  Penlook Development Team
 * @license    GNU Affero General Public
 * @version    1.0
 * @link       http://github.com/penlook
 * @since      Class available since Release 1.0
 */
abstract class Transport {

    /**
     * HTTP Synchronous request
     *
     * @param Context context
     * @param Option option
     * @param Function response_callback
     */
    void syncRequest(Object context, 
                     Option option, 
                     Function response_callback(Object context, Map<String, Map> response_callback)) {

        // Initialize new HTTP Request
        HttpRequest request = new HttpRequest();
        request.open(option.Method, option.Url, async: false);

        Map<String, Map> response = null;

        try {
           request.send(option.Data.toString());
           response = JSON.decode(request.responseText);
        } catch (e) {
          throw request.responseText;
           //throw e;
        }

        response_callback(context, response);
        
    }

    /**
     * HTTP Asynchronous request
     *
     * @param Context context
     * @param Option option
     * @param Function response_callback
     * @param Function timeout_callback 
     */
    void asyncRequest(Object context, 
                      Option option, 
                      Function response_callback(Object context, Map<String, Map> response_callback),
                      Function timeout_callback(Object context)) {

        HttpRequest request = new HttpRequest();

        request.onReadyStateChange.listen((_) {
            if (request.readyState == HttpRequest.DONE &&
                (request.status == 200 || request.status == 0)) {

                Map<String, Map> response = null;

                try {
                    response = JSON.decode(request.responseText);
                } catch (e) {
                   throw e;
                }

                response_callback(context, response);
            }
        });
        
        request.onTimeout.listen((_) {
            if (timeout_callback != null)  {
                timeout_callback(context);
            }
        });

        request.open(option.Method, option.Url, async: option.Async);
        request.timeout = option.Timeout;

        try {
            request.send(option.Data.toString());
        } catch (e) {
            throw e;
        }
        
    }

    /**
     * Send HTTP Request
     *
     * @param Object context
     * @param Option option
     * @param Function response_callback
     * @param [optional] Function timeout_callback
     */
    void sendRequest(Object context, 
                     Option option, 
                     Function response_callback(Object context, Map<String, Map> response_callback),
                     {Function timeout_callback(Object timeout_callback)}) {
      
        option.Async ?
            this.asyncRequest(context, option, response_callback, timeout_callback) :
                this.syncRequest(context, option, response_callback);
        
    }

}