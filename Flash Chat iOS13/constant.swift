//
//  constant.swift
//  Flash Chat iOS13
//
//  Created by yousef Elaidy on 03/12/2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import Foundation

struct K {
    static let appname = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "cellformessage"
    static let registerSegue = "registertohome"
    static let loginSegue = "logintohome"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
