//
//  StorageFileSystem.swift
//  MahaStorageKit
//

import Foundation

struct StorageFileSystem {
    private let manager = FileManager.default

    func fileExists(atPath path: String) -> Bool {
        manager.fileExists(atPath: normalizedPath(from: path))
    }

    func allFiles(in directoryPath: String) -> [String] {
        let normalizedDirectoryPath = normalizedPath(from: directoryPath)
        let fileNames = try? manager.contentsOfDirectory(atPath: normalizedDirectoryPath)
        return fileNames ?? []
    }

    func deleteFile(atPath path: String) {
        let normalizedFilePath = normalizedPath(from: path)
        do {
            try manager.removeItem(atPath: normalizedFilePath)
        } catch {
            // MahaLog.record("deleteFile失败=\(error)")
        }
    }

    func createDirectoryIfNeeded(atPath path: String) {
        let normalizedDirectoryPath = normalizedPath(from: path)
        let directoryExists = manager.fileExists(atPath: normalizedDirectoryPath)
        if directoryExists == false {
            do {
                try manager.createDirectory(atPath: normalizedDirectoryPath, withIntermediateDirectories: true)
            } catch {
                // MahaLog.recordError("创建文件夹失败=\(normalizedDirectoryPath) err = \(error)")
            }
        }
    }

    private func normalizedPath(from path: String) -> String {
        if path.hasPrefix("file://") {
            return path.replacingOccurrences(of: "file://", with: "")
        }
        return path
    }
}
