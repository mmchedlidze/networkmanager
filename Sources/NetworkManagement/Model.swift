//
//  File.swift
//  
//
//  Created by Mariam Mchedlidze on 20.11.23.
//

import Foundation

struct MoviesResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let title: String
   
    enum CodingKeys: String, CodingKey {
       
        case title
    }
}
