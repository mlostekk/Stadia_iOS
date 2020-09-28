// Copyright (c) 2020 Nomad5. All rights reserved.

import Foundation

/// Some configuration values
struct Config {
    struct Url {
        static let stadia   = URL(string: "https://stadia.google.com")!
        static let login    = URL(string: "https://accounts.google.com")!
        static let loggedIn = URL(string: "https://myaccount.google.com/")!
    }

    struct UserAgent {
        static let chromeDesktop = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36"
    }
}