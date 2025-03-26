//
//  AppDatabaseManager+Migration.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 26/3/25.
//

import GRDB

extension AppDatabaseManager {
    var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        migrator.registerMigration("v1") { database in
            try? database.create(table: "products") { table in
                table.primaryKey("id", .integer)
                table.column("title", .text)
                table.column("price", .double)
                table.column("thumbnail", .text)
            }
        }
        return migrator
    }
}
