//
//  MahaStorageManager.swift
//  MahaStorageKit
//

import Foundation
import MahaLogCore

public final class MahaStorageManager {
    private static let defaultRootDirectoryName = "/Maha/"
    public private(set) static var rootDirectoryName = defaultRootDirectoryName

    public enum Directory: String, CaseIterable {
        case normal = "normal/"
        case animation = "animation/"
        case log = "logs/"
        case other = "other/"
        case music = "music/"
        case expression = "expression/"
        case db = "db/"
        case lanuch = "lanuch/"
        case theme = "theme/"
    }

    public static let shared = MahaStorageManager(rootDirectoryName: defaultRootDirectoryName)

    public static func configure(rootDirectoryName: String) {
        let normalizedRootDirectoryName = normalizeRootDirectoryName(rootDirectoryName)
        self.rootDirectoryName = normalizedRootDirectoryName
        shared.updateRootDirectoryName(normalizedRootDirectoryName)
    }

    private let fileManager = FileManager.default
    private var rootDirectoryName: String
    private var rootDirectoryPath = ""

    private init(rootDirectoryName: String) {
        self.rootDirectoryName = Self.normalizeRootDirectoryName(rootDirectoryName)
        reloadRootDirectoryPath()
    }

    public var currentRootDirectoryPath: String {
        rootDirectoryPath
    }

    private func updateRootDirectoryName(_ rootDirectoryName: String) {
        self.rootDirectoryName = rootDirectoryName
        reloadRootDirectoryPath()
    }

    private func reloadRootDirectoryPath() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths.first ?? ""
        rootDirectoryPath = documentDirectory + rootDirectoryName

        Directory.allCases.forEach { directory in
            createDirectory(at: rootDirectoryPath + directory.rawValue)
        }
    }

    public func createDirectory(at directoryPath: String) {
        let exists = fileManager.fileExists(atPath: directoryPath)
        if exists == false {
            do {
                try fileManager.createDirectory(atPath: directoryPath, withIntermediateDirectories: true)
            } catch {
                // MahaLog.recordError("创建文件夹失败=\(directoryPath) err = \(error)")
            }
        }
    }

    /// 判断文件是否存在
    public func fileExists(named fileName: String, in directory: Directory = .normal) -> Bool {
        let fullPath = filePath(for: fileName, in: directory)
        return fileExists(atFullPath: fullPath)
    }

    /// 获取文件完整路径
    public func filePath(for fileName: String, in directory: Directory = .normal) -> String {
        rootDirectoryPath + directory.rawValue + fileName
    }

    public func fileExists(atFullPath fullPath: String) -> Bool {
        let path = normalizedPath(from: fullPath)
        return fileManager.fileExists(atPath: path)
    }

    /// 获取类型目录
    public func directoryPath(for directory: Directory) -> String {
        rootDirectoryPath + directory.rawValue
    }

    /// 获取目录下所有文件名
    public func allFiles(in directoryPath: String) -> [String] {
        let path = normalizedPath(from: directoryPath)
        let contents = try? fileManager.contentsOfDirectory(atPath: path)
        return contents ?? []
    }

    public func deleteFile(atFullPath filePath: String) {
        let path = normalizedPath(from: filePath)
        do {
            try fileManager.removeItem(atPath: path)
        } catch {
            // MahaLog.record("deleteFile失败=\(error)")
        }
    }

    private func normalizedPath(from originalPath: String) -> String {
        if originalPath.hasPrefix("file://") {
            return originalPath.replacingOccurrences(of: "file://", with: "")
        }
        return originalPath
    }

    private static func normalizeRootDirectoryName(_ rootDirectoryName: String) -> String {
        let trimmedRootDirectoryName = rootDirectoryName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmedRootDirectoryName.isEmpty == false else {
            return defaultRootDirectoryName
        }

        var normalizedRootDirectoryName = trimmedRootDirectoryName
        if normalizedRootDirectoryName.hasPrefix("/") == false {
            normalizedRootDirectoryName = "/" + normalizedRootDirectoryName
        }
        if normalizedRootDirectoryName.hasSuffix("/") == false {
            normalizedRootDirectoryName += "/"
        }
        return normalizedRootDirectoryName
    }
}
