//
//  SystemEntryType.swift
//  
//
//  Created by Kévin Sibué on 27/09/2022.
//

import Foundation

public protocol SystemEntryType: Attribuable {
    var path: URL { get }
    func delete() throws
}
