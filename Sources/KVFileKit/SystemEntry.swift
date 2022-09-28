//
//  SystemEntry.swift
//  
//
//  Created by Kévin Sibué on 27/09/2022.
//

import Foundation

public class SystemEntry: SystemEntryType {

    public var isReadable: Bool { fileManager.isReadableFile(atPath: path.path) }

    public var isWritable: Bool { fileManager.isWritableFile(atPath: path.path) }

    public var isExecutable: Bool { fileManager.isExecutableFile(atPath: path.path) }

    public var isDeletable: Bool { fileManager.isDeletableFile(atPath: path.path) }

    public let path: URL
    public let fileSystem: FileSystemType
    public let fileManager: FileManager

    init(fileManager: FileManager, path: URL, fileSystem: FileSystemType) {
        self.fileManager = fileManager
        self.path = path
        self.fileSystem = fileSystem
    }

    public func delete() throws {
        try fileManager.removeItem(at: path)
    }

}
