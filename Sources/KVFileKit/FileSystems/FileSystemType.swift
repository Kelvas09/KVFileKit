//
//  FileSystemType.swift
//  
//
//  Created by Kévin Sibué on 27/09/2022.
//

import Foundation

public protocol FileSystemType {
    func getFile(from path: URL) -> FileType?
    func getDirectory(from path: URL) -> DirectoryType?
    func getEntries(from path: URL) -> [SystemEntryType]
}
