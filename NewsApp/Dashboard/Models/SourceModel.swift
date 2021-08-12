//
//  SourceModel.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 12/08/2021.
//

import Foundation

enum SourceModelKeys {
    static let id = "idKey"
    static let name = "nameKey"
}

class SourceModel: NSObject, Codable, NSCoding {
    var id: String?
    var name: String

    enum CodingKeys: CodingKey {
        case id
        case name
    }

    override init() {
        id = nil
        name = ""
    }
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: SourceModelKeys.id)
        coder.encode(name, forKey: SourceModelKeys.name)
    }

    required init?(coder: NSCoder) {
        id = coder.decodeObject(forKey: SourceModelKeys.id) as? String
        name = coder.decodeObject(forKey: SourceModelKeys.name)  as? String ?? ""
    }
}
