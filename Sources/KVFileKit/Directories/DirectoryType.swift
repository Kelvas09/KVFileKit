//
//  DirectoryType.swift
//  
//
//  Created by Kévin Sibué on 27/09/2022.
//

import Foundation

public protocol DirectoryType: SystemEntryType {
    var isReadable: Bool { get }
    var isWritable: Bool { get }
    var isExecutable: Bool { get }
    var entries: [SystemEntryType] { get }
    func createFile(with name: String, ext: String) throws -> File
    func createDirectory(with name: String) throws -> Directory
    func clear(recursively: Bool) throws
}
