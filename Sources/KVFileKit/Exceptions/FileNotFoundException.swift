//
//  FileNotFoundException.swift
//  
//
//  Created by Kévin Sibué on 27/09/2022.
//

import Foundation

public final class FileNotFoundException: Exception {

    public init(at path: String) {
        super.init(code: 0, title: Exception.undefined, description: "File at path <\(path)> not found")
    }

}
