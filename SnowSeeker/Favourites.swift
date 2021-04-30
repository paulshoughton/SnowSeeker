//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Paul Houghton on 23/04/2021.
//

import SwiftUI

class Favourites: ObservableObject {
    private var resorts: Set<String>
    
    private let saveKey = "Favourites"
    
    init() {
        self.resorts = []
        
        // load data
        load()
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // write out our data
        if let encoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func load() {
        // read in our data
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                self.resorts = decoded
                return
            }
        }
    }
}
