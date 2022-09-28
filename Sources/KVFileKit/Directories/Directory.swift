//
//  Directory.swift
//  
//
//  Created by Kévin Sibué on 27/09/2022.
//

import Foundation

public final class Directory: SystemEntry, DirectoryType {

    public var entries: [SystemEntryType] { fileSystem.getEntries(from: self.path) }

    public func createFile(with name: String, ext: String) throws -> File {
        let filePath = path.appendingPathComponent("\(name).\(ext)", isDirectory: false)
        if fileManager.fileExists(atPath: filePath.path) {
            throw FileAlreadyExistsException(at: filePath.path)
        }
        fileManager.createFile(atPath: filePath.path, contents: nil, attributes: nil)
        return File(fileManager: fileManager, path: filePath, fileSystem: fileSystem)
    }

    public func createDirectory(with name: String) throws -> Directory {
        let directoryPath = path.appendingPathComponent(name, isDirectory: true)
        if fileManager.fileExists(atPath: directoryPath.path) {
            throw FileAlreadyExistsException(at: directoryPath.path)
        }
        try fileManager.createDirectory(at: directoryPath, withIntermediateDirectories: false)
        return Directory(fileManager: fileManager, path: directoryPath, fileSystem: fileSystem)
    }

    public func clear(recursively: Bool) throws {
        for entry in entries {
            if let directory = entry as? Directory, recursively {
                try directory.clear(recursively: recursively)
            }
            try entry.delete()
        }
    }

}
