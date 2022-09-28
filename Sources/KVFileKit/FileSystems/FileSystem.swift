//
//  FileSystem.swift
//  
//
//  Created by Kévin Sibué on 27/09/2022.
//

import Foundation

public final class FileSystem: FileSystemType {

    private let fileManager: FileManager

    public init(fileManager: FileManager) {
        self.fileManager = fileManager
    }

    public func getFile(from path: URL) -> FileType? {
        if !fileManager.fileExists(atPath: path.path) {
            return nil
        }
        return File(fileManager: fileManager, path: path, fileSystem: self)
    }

    public func getDirectory(from path: URL) -> DirectoryType? {
        if !fileManager.fileExists(atPath: path.path) {
            return nil
        }
        return Directory(fileManager: fileManager, path: path, fileSystem: self)
    }

    public func getEntries(from path: URL) -> [SystemEntryType] {
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(
                at: path,
                includingPropertiesForKeys: nil
            )
            var entries: [SystemEntryType] = []
            directoryContents.forEach { url in
                var entry: SystemEntryType?
                if url.isDirectory {
                    entry = getDirectory(from: url)
                } else {
                    entry = getFile(from: url)
                }
                if let entry = entry {
                    entries.append(entry)
                }
            }
            return entries
        } catch {
            return []
        }
    }

}
