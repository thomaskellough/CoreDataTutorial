//
//  URLExtensions.swift
//  ShoutOut
//
//  Created by Thomas Kellough on 7/2/20.
//  Copyright © 2020 pluralsight. All rights reserved.
//

import Foundation

extension URL {
    static var documentsURL: URL {
        return try! FileManager
        .default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}
