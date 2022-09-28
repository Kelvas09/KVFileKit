//
//  Exception.swift
//  
//
//  Created by Kévin Sibué on 27/09/2022.
//

import Foundation

public class Exception: Error {

    static let undefined: String = "Undefined"

    public let code: Int
    public let title: String
    public let description: String

    public convenience init(code: Int) {
        self.init(code: code, title: Exception.undefined, description: Exception.undefined)
    }

    public convenience init(code: Int, description: String) {
        self.init(code: code, title: Exception.undefined, description: description)
    }

    public init(code: Int, title: String, description: String) {
        self.code = code
        self.title = title
        self.description = description
    }

}
