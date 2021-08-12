//
//  String+SaveToFile.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 12/08/2021.
//

import Foundation

extension Data {
    func saveToFile(with name: String) {
        guard
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        do {
            let pathWithFilename = documentDirectory.appendingPathComponent("\(name).json")
            try? self.write(to: pathWithFilename)
        }
    }
}
