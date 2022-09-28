//
//  Attribuable.swift
//  
//
//  Created by Kévin Sibué on 27/09/2022.
//

import Foundation

public protocol Attribuable {
    var isReadable: Bool { get }
    var isWritable: Bool { get }
    var isExecutable: Bool { get }
    var isDeletable: Bool { get }
}
