//
//  Network.swift
//  PokeApiSwiftUI
//
//  Created by Ricardo Garcia on 14/06/24.
//

import Foundation

struct ApiMorty:Codable{
    let info:InfoMorty?
    let results:[ResultMorty]?
}

struct InfoMorty: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

struct ResultMorty:Codable {
    let id:Int?
    let name:String?
    let status:String?
    let species:String?
    let type:String?
    let gender:String?
    let origin:LocationMorty?
    let location:LocationMorty?
    let image:String?
    let episode:[String]?
    let url:String?
    let created:String?
}

struct LocationMorty:Codable {
    let name:String?
    let url:String?
}
