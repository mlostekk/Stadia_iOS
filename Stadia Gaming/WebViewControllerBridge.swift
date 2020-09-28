// Copyright (c) 2020 Nomad5. All rights reserved.

import Foundation
import WebKit
import GameController

/// Main module that connects the web views controller scripts to the native controller handling
class WebViewControllerBridge: NSObject, WKScriptMessageHandlerWithReply {

    /// Handle user content controller with proper native controller data reply
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage,
                               replyHandler: @escaping (Any?, String?) -> Void) {
        replyHandler(GCController.controllers().first?.extendedGamepad?.toJson(), nil)
    }
}
