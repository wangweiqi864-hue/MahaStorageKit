//
//  StorageLayout.swift
//  MahaStorageKit
//

import Foundation

struct StorageLayout {
    private static let defaultRootDirectoryName = "/Maha/"

    private(set) var rootDirectoryName: String

    init(rootDirectoryName: String = defaultRootDirectoryName) {
        self.rootDirectoryName = Self.sanitizedRootDirectoryName(from: rootDirectoryName)
    }

    var rootDirectoryPath: String {
        Self.documentsDirectoryPath() + rootDirectoryName
    }

    mutating func updateRootDirectoryName(_ rootDirectoryName: String) {
        self.rootDirectoryName = Self.sanitizedRootDirectoryName(from: rootDirectoryName)
    }

    func directoryPath(for directory: MahaStorageManager.Directory) -> String {
        rootDirectoryPath + directory.rawValue
    }

    func filePath(for fileName: String, in directory: MahaStorageManager.Directory) -> String {
        directoryPath(for: directory) + fileName
    }

    private static func documentsDirectoryPath() -> String {
        let documentDirectoryPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return documentDirectoryPaths.first ?? ""
    }

    private static func sanitizedRootDirectoryName(from rootDirectoryName: String) -> String {
        let trimmedRootDirectoryName = rootDirectoryName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmedRootDirectoryName.isEmpty == false else {
            return defaultRootDirectoryName
        }

        var sanitizedRootDirectoryName = trimmedRootDirectoryName
        if sanitizedRootDirectoryName.hasPrefix("/") == false {
            sanitizedRootDirectoryName = "/" + sanitizedRootDirectoryName
        }
        if sanitizedRootDirectoryName.hasSuffix("/") == false {
            sanitizedRootDirectoryName += "/"
        }
        return sanitizedRootDirectoryName
    }
}
