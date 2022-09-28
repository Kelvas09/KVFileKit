//
//  URL+Extensions.swift
//  
//
//  Created by Kévin Sibué on 27/09/2022.
//

import Foundation

extension URL {

    var isDirectory: Bool {
       (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }

}
