//
//  ViewModel.swift
//  PokeApiSwiftUI
//
//  Created by Ricardo Garcia on 14/06/24.
//

import Foundation

@Observable
class ViewModel {
    var mortyData: ApiMorty? = nil

    func getResponseMorty() async throws {
        let url = URL(string:"https://rickandmortyapi.com/api/character")
        
        let (data, _) = try await URLSession.shared.data(from: url!)
        
        let wrapper = try JSONDecoder().decode(ApiMorty.self, from: data)
        
        mortyData = wrapper
        
    }
    
    
    func searchResponseMorty(character:String) async throws {
        let url = URL(string:"https://rickandmortyapi.com/api/character/?name=\(character)")
        
        let (data, _) = try await URLSession.shared.data(from: url!)
        
        let wrapper = try JSONDecoder().decode(ApiMorty.self, from: data)
        
        print(wrapper)
                
        mortyData = wrapper
        
    }
    
}
