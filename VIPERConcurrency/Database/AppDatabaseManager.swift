//
//  AppDatabaseManager.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 25/3/25.
//

import Foundation
import GRDB

enum FileSharedManager {
    static func getAppDirectory() -> URL {
        FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "thanhfnx")
            ?? FileManager.default.temporaryDirectory
    }
}

protocol AppDatabase: Sendable {
    func getAll<T: DatabaseEntity>() async throws -> [T]
    func saveAll<T: DatabaseEntity>(_ records: [T]) async throws
}

typealias DatabaseEntity = FetchableRecord & PersistableRecord & TableRecord & Sendable

final class AppDatabaseManager: AppDatabase {
    private enum DatabaseConstants {
        static let databaseFolder = "database"
        static let databaseName = "app.db"
        static let saltHexString = "F80888AEA96115F6F5325051889436AA"
    }

    private let database: DatabasePool!

    init() {
        let fileManager = FileManager()
        let folderUrl = FileSharedManager.getAppDirectory().appendingPathComponent(
            DatabaseConstants.databaseFolder,
            isDirectory: true
        )
        try? fileManager.createDirectory(at: folderUrl, withIntermediateDirectories: true)
        let databaseUrl = folderUrl.appendingPathComponent(DatabaseConstants.databaseName)
        let configuration = Configuration()
        database = try? DatabasePool(path: databaseUrl.path, configuration: configuration)
        try? migrator.migrate(database)
    }

    func getAll<T: DatabaseEntity>() async throws -> [T] {
        let records = try await database.read { database in
            try T.fetchAll(database)
        }
        print("Loaded \(records.count) records of type [\(T.self)] from local database.")
        return records
    }

    func saveAll<T: DatabaseEntity>(_ records: [T]) async throws {
        try await withThrowingTaskGroup(of: Void.self) { group in
            records.forEach { record in
                group.addTask {
                    try await self.database.write { database in
                        try record.insert(database, onConflict: .replace)
                    }
                }
            }
            for try await _ in group {}
        }
        print("Saved \(records.count) records of type [\(T.self)] to local database.")
    }
}
