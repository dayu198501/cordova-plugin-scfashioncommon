cordova.define("cordova-plugin-scfashioncommon.scfashioncommon", function(require, exports, module) {

   var exec = require("cordova/exec");

   module.exports = {

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
        doNativeFunction : function (successCallback, errorCallback, method, parameter) {
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
        },

        getUserInfo : function (successCallback, errorCallback) {
            if (errorCallback == null) {
                errorCallback = function () {
                };
            }
            exec(successCallback, errorCallback, 'CommonPlugin', "getUserInfo", []);
        },

        setUserInfo : function (successCallback, errorCallback, phone, guid) {
            if (errorCallback == null) {
                errorCallback = function () {
                };
            }
            exec(successCallback, errorCallback, 'CommonPlugin', "setUserInfo", [
                {"phone": phone, "guid": guid}
            ]);
        },

        getVersionAndRegistrationID : function (successCallback, errorCallback) {
            if (errorCallback == null) {
                errorCallback = function () {
                };
            }
            exec(successCallback, errorCallback, 'CommonPlugin', "getVersionAndRegistrationID", []);
        },

        clearUserInfo : function () {
            exec(function () {
            }, function () {
            }, 'CommonPlugin', "clearUserInfo", []);
        },

        openNewPage : function (page) {
            exec(function () {
            }, function () {
            }, 'CommonPlugin', "openNewPage", [
                {"page": page}
            ]);
        },

        exitApp : function () {
            exec(function () {
            }, function () {
            }, 'CommonPlugin', "exitApp", []);
        },

        log : function (info) {

            exec(function () {
            }, function () {
            }, 'CommonPlugin', "log", [
                {"info": info}
            ]);
        },
    };

});
