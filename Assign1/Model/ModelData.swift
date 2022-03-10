//
//  ModelData.swift
//  Assign1
//
//  Created by Nancy Jain on 09/03/22.
//

import Foundation


struct ModelData: Decodable {
    var country: String
    var countryInfo: CountryFlag
    var continent: String
}

struct CountryFlag: Decodable {
    var flag: String
}
//base model array of country




