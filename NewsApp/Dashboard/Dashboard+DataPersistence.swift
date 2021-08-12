//
//  Dashboard+DataPersistence.swift
//  NewsApp
//
//  Created by Mohamed Abd ElNasser on 12/08/2021.
//

import Foundation

extension DashboardViewController {
    func saveResponse(model: NewsModel) {
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: false) else {
            return
        }
        data.saveToFile(with: FilesNamesConstants.latestResponse)
    }

    func retrieveResponse(from fileName: String, completion: (NewsModel?) -> Void) {
        guard
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(nil)
            return
        }
        do {
            let pathWithFilename = documentDirectory.appendingPathComponent("\(fileName).json")
            guard let data = try? Data(contentsOf: pathWithFilename) else { return }
            guard let model = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NewsModel else { return }
            completion(model)
        }
    }
}
