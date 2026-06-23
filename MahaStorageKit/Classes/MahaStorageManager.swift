//
//  MahaStorageManager.swift
//  MahaStorageKit
//

import Foundation

public final class MahaStorageManager {
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

    public static let shared = MahaStorageManager()

    private let fileSystem = StorageFileSystem()
    private var storageLayout = StorageLayout()

    private init() {
        prepareDefaultDirectories()
    }
}

public extension MahaStorageManager {
    public var currentRootDirectoryPath: String {
        storageLayout.rootDirectoryPath
    }

    static func configure(rootDirectoryName: String) {
        shared.updateRootDirectory(to: rootDirectoryName)
    }

    func createBaseDir() {
        prepareDefaultDirectories()
    }

    func createDirectory(at directoryPath: String) {
        fileSystem.createDirectoryIfNeeded(atPath: directoryPath)
    }

    /// 判断文件是否存在
    func fileExists(named fileName: String, in directory: Directory = .normal) -> Bool {
        fileSystem.fileExists(atPath: storageLayout.filePath(for: fileName, in: directory))
    }

    /// 获取文件完整路径
    func filePath(for fileName: String, in directory: Directory = .normal) -> String {
        storageLayout.filePath(for: fileName, in: directory)
    }

    func fileExists(atFullPath fullPath: String) -> Bool {
        fileSystem.fileExists(atPath: fullPath)
    }

    /// 获取类型目录
    func directoryPath(for directory: Directory) -> String {
        storageLayout.directoryPath(for: directory)
    }

    /// 获取目录下所有文件名
    func allFiles(in directoryPath: String) -> [String] {
        fileSystem.allFiles(in: directoryPath)
    }

    func deleteFile(atFullPath filePath: String) {
        fileSystem.deleteFile(atPath: filePath)
    }
}

private extension MahaStorageManager {
    func updateRootDirectory(to rootDirectoryName: String) {
        storageLayout.updateRootDirectoryName(rootDirectoryName)
        prepareDefaultDirectories()
    }

    func prepareDefaultDirectories() {
        Directory.allCases.forEach { directory in
            fileSystem.createDirectoryIfNeeded(atPath: storageLayout.directoryPath(for: directory))
        }
    }
}
