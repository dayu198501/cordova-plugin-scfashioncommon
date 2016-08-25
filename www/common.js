cordova.define("com.scfashion.sale.plugins.CommonPlugin", function (require, exports, module) {
    /**
     * cordova is available under *either* the terms of the modified BSD license *or* the
     * MIT License (2008). See http://opensource.org/licenses/alphabetical for full text.
     *
     * Copyright (c) Matt Kane 2010
     * Copyright (c) 2011, IBM Corporation
     */

    var CommonIOS = function (require, exports, module) {

        var exec = require("cordova/exec");

        /**
         * Constructor.
         *
         * @returns {BarcodeScanner}
         */
        function CommonPlugin() {
        };

        /**
         * Read code from scanner.
         *
         * @param {Function} successCallback This function will recieve a result object: {
         *        text : '12345-mock',    // The code that was scanned.
         *        format : 'FORMAT_NAME', // Code format.
         *        cancelled : true/false, // Was canceled.
         *    }
         * @param {Function} errorCallback
         */
        CommonPlugin.prototype.doNativeFunction = function (successCallback, errorCallback, method, parameter) {
            if (errorCallback == null) {
                errorCallback = function () {
                };
            }

            if (typeof errorCallback != "function") {
                console.log("BarcodeScanner.scan failure: failure parameter not a function");
                return;
            }

            if (typeof successCallback != "function") {
                console.log("BarcodeScanner.scan failure: success callback parameter must be a function");
                return;
            }
            // exec(successCallback, errorCallback, 'CommonPlugin', method, parameter);
            exec(successCallback, errorCallback, 'CommonPlugin', method, parameter);
        };

        CommonPlugin.prototype.getUserInfo = function (successCallback, errorCallback) {
            if (errorCallback == null) {
                errorCallback = function () {
                };
            }
            exec(successCallback, errorCallback, 'CommonPlugin', "getUserInfo", []);
        };

        CommonPlugin.prototype.setUserInfo = function (successCallback, errorCallback, phone, guid) {
            if (errorCallback == null) {
                errorCallback = function () {
                };
            }
            exec(successCallback, errorCallback, 'CommonPlugin', "setUserInfo", [
                {"phone": phone, "guid": guid}
            ]);
        };

        CommonPlugin.prototype.getVersionAndRegistrationID = function (successCallback, errorCallback) {
            if (errorCallback == null) {
                errorCallback = function () {
                };
            }
            exec(successCallback, errorCallback, 'CommonPlugin', "getVersionAndRegistrationID", []);
        };

        CommonPlugin.prototype.clearUserInfo = function () {
            exec(function () {
            }, function () {
            }, 'CommonPlugin', "clearUserInfo", []);
        };

        CommonPlugin.prototype.openNewPage = function (page) {
            exec(function () {
            }, function () {
            }, 'CommonPlugin', "openNewPage", [
                {"page": page}
            ]);
        };

        CommonPlugin.prototype.exitApp = function () {
            exec(function () {
            }, function () {
            }, 'CommonPlugin', "exitApp", []);
        };

        CommonPlugin.prototype.log = function (info) {

            exec(function () {
            }, function () {
            }, 'CommonPlugin', "log", [
                {"info": info}
            ]);
        };

        var commonPlugin = new CommonPlugin();
        module.exports = commonPlugin;

    }

    CommonIOS(require, exports, module);

    cordova.define("cordova/plugins/CommonPlugin", CommonIOS);

});
