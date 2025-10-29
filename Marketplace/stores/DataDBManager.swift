//
//  DataDBManager.swift
//  Marketplace
//
//  Created by Jeffery Okoli on 24/10/2025.
//
import SwiftUI
import SwiftData

@MainActor
class DataManager: ObservableObject {
    @Published var favoriteIDs: Set<String> = []
    let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func add<T: PersistentModel>(_ item: T) {
        modelContext.insert(item)
        self.save()
    }

    func delete(_ object: some PersistentModel, in context: ModelContext) {
        context.delete(object)
       
        do {
            try context.save()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func itemExists<T: PersistentModel>(_ type: T.Type, predicate: Predicate<T>) -> Bool {
        do {
            let descriptor = FetchDescriptor<T>(predicate: predicate)
            let result = try modelContext.fetch(descriptor)
            return !result.isEmpty
        } catch {
            print("\(error.localizedDescription)")
            return false
        }
    }
    
    func fetchSingleItem<T: PersistentModel>(_ type: T.Type, predicate: Predicate<T>, in context: ModelContext) -> T? {
        do {
            let descriptor = FetchDescriptor<T>(predicate: predicate)
            let result = try context.fetch(descriptor)
            return result.first
        } catch {
            print("\(error.localizedDescription)")
            return nil
        }
    }

    func save() {
        do {
            try modelContext.save()
        } catch {
            print("Error saving: \(error.localizedDescription)")
        }
    }
}

