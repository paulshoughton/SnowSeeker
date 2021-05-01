//
//  Resort.swift
//  SnowSeeker
//
//  Created by Paul Houghton on 20/04/2021.
//

import Foundation

struct Resorts {
   
    let resorts: [Resort]
    
    var countries: Set<String> = Set<String>()
    var prices: Set<Int> = [1, 2, 3]
    var sizes: Set<Int> = [1, 2, 3]
    
    init() {
        resorts = Bundle.main.decode("resorts.json")
                
        resorts.forEach { resort in
            countries.insert(resort.country)

        }
        
        print(countries.sorted())
        print(prices)
        print(sizes)
    }
    
    static func sizeToString(_ sizeNumber: Int) -> String {
        var sizeString: String
            
        switch sizeNumber {
        case 1:
            sizeString = "Small"
        case 2:
            sizeString = "Average"
        default:
            sizeString = "Large"
        }
            
        return sizeString
        
    }
    
    static func priceToString(_ priceNumber: Int) -> String {
        return String(repeating: "$", count: priceNumber)
    }
    
}

struct Resort: Codable, Identifiable, Comparable {
    static func < (lhs: Resort, rhs: Resort) -> Bool {
        lhs.name < rhs.name
    }
    
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}
