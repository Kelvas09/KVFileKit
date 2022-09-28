//
//  File.swift
//  
//
//  Created by Kévin Sibué on 27/09/2022.
//

import Foundation

public final class File: SystemEntry, FileType {

    public func readData() -> Data? {
        do {
            return try Data(contentsOf: path)
        } catch {
            return nil
        }
    }

    public func readAsString() -> String? {
        do {
            return try String(contentsOf: path, encoding: .utf8)
        } catch {
            return nil
        }
    }

    public func write(data: Data) throws {
        try data.write(to: path)
    }

    public func write(string: String) throws {
        try string.write(to: path, atomically: false, encoding: .utf8)
    }

    @available(iOS 13.0, *)
    @available(macOS 10.15, *)
    public func readDataAsync() async -> Data? {
        await withCheckedContinuation({ continuation in
            Task {
                let data = readData()
                continuation.resume(returning: data)
            }
        })
    }

    @available(iOS 13.0, *)
    @available(macOS 10.15, *)
    public func readAsString() async -> String? {
        await withCheckedContinuation({ continuation in
            Task {
                let string = readAsString()
                continuation.resume(returning: string)
            }
        })
    }

    @available(iOS 13.0, *)
    @available(macOS 10.15, *)
    public func writeAsync(data: Data) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            Task {
                do {
                    try write(data: data)
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        })
    }

    @available(iOS 13.0, *)
    @available(macOS 10.15, *)
    public func writeAsync(string: String) async throws {
        try await withCheckedThrowingContinuation({ continuation in
            Task {
                do {
                    try write(string: string)
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        })
    }

}
