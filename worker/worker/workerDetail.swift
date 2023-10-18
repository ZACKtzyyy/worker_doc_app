//
//  workerDetail.swift
//  worker
//
//  Created by Common Room Bangi on 01/10/2023.
//

import Foundation

struct Worker: Codable {
    var name: String
    var email: String
    var numberphone : String
    var imageData : Data
    // Landmark now supports the Codable methods init(from:) and encode(to:),
    // even though they aren't written as part of its declaration.
}
