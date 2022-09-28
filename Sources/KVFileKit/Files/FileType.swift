//
//  FileType.swift
//  
//
//  Created by Kévin Sibué on 27/09/2022.
//

import Foundation

public protocol FileType: SystemEntryType {

    var isReadable: Bool { get }
    var isWritable: Bool { get }
    var isExecutable: Bool { get }

    func readData() -> Data?
    func readAsString() -> String?
    func write(data: Data) throws
    func write(string: String) throws

    @available(iOS 13.0, *)
    @available(macOS 10.15, *)
    func readDataAsync() async -> Data?

    @available(iOS 13.0, *)
    @available(macOS 10.15, *)
    func readAsString() async -> String?

    @available(iOS 13.0, *)
    @available(macOS 10.15, *)
    func writeAsync(data: Data) async throws

    @available(iOS 13.0, *)
    @available(macOS 10.15, *)
    func writeAsync(string: String) async throws

}
