//
//  MissingFileDataException.swift
//  
//
//  Created by Kévin Sibué on 27/09/2022.
//

import Foundation

public final class MissingFileDataException: Exception {

    public init() {
        super.init(code: 0, title: Exception.undefined, description: "File has no data")
    }

}
