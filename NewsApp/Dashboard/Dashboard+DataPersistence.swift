//
//  Dashboard+DataPersistence.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 12/08/2021.
//

import Foundation

extension DashboardViewController {
    func saveResponse<T>(model: T, to fileName: String) {
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: false) else {
            return
        }
        data.saveToFile(with: fileName)
    }

    func retrieveResponse<T>(
        from fileName: String,
        type: T.Type,
        completion: (T?) -> Void) {
        guard
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(nil)
            return
        }
        do {
            let pathWithFilename = documentDirectory.appendingPathComponent("\(fileName).json")
            guard let data = try? Data(contentsOf: pathWithFilename) else {
                completion(nil)
                return
            }
            guard let model = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
}
