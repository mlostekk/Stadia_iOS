// Copyright (c) 2020 Nomad5. All rights reserved.

import Foundation
import WebKit
import GameController

/// The script to be injected into the webview
/// It's overwriting the navigator.getGamepads function
/// to make the connection with the native GCController solid
private let script = """
                     var emulatedGamepad = {
                         id: "Emulated iOS Controller",
                         index: 0,
                         connected: true,
                         timestamp: 0,
                         mapping: "standard",
                         axes: [0, 0, 0, 0],
                         buttons: new Array(17).fill().map(m => ({pressed: false, touched: false, value: 0}))
                     }

                     navigator.getGamepads = function() {
                         window.webkit.messageHandlers.controller.postMessage({}).then((controllerData) => {
                             try {
                                 var data = JSON.parse(controllerData);
                                 for(let i = 0; i < data.buttons.length; i++) {
                                     emulatedGamepad.buttons[i].pressed = data.buttons[i].pressed;
                                     emulatedGamepad.buttons[i].value = data.buttons[i].value;
                                 }
                                 for(let i = 0; i < data.axes.length; i++) {
                                     emulatedGamepad.axes[i] = data.axes[i]
                                 }
                             } catch(e) { }
                         });
                         return [emulatedGamepad, null, null, null];
                     };
                     """

extension WKWebView: WKNavigationDelegate {

    /// Inject inject the js controller script
    func injectControllerScript() {
        evaluateJavaScript(script, completionHandler: nil)
    }

    /// Override user agent and navigate to stadia
    func navigateToStadia() {
        customUserAgent = Config.UserAgent.chromeDesktop
        load(URLRequest(url: Config.Url.stadia))
    }
}