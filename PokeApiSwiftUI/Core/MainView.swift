//
//  MainView.swift
//  PokeApiSwiftUI
//
//  Created by Ricardo Garcia on 14/06/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    
    @State var character:String = ""
    @State var loading = false
    @State var apiResponse:ApiMorty? = nil
    @State private var model = ViewModel()
    
    var body: some View {
        
        VStack {
            
            SearchSectionView(character: $character, model: $model)

            if loading {
                ProgressView().tint(.gray)
            }
            
            List(model.mortyData?.results ?? [], id: \.id) { result in
                GroupBox {
                    WebImage(url: URL(string: result.image ?? ""))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                } label: {
                    Text(result.name ?? "")
                }
            }
            .listStyle(.plain)
            .refreshable {
                do {
                    try await model.getResponseMorty()
                } catch {
                    print("Error")
                }
            }
            
            Spacer()
        }.onAppear{
            loading = true
            Task{
                do {
                    try await model.getResponseMorty()
                } catch {
                    print("Error")
                }
                loading = false
            }
        }
    }
}

struct SearchSectionView:View {
    @Binding var character:String
    @Binding var model:ViewModel
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("",text: $character,prompt: Text("Morty..."))
                .autocorrectionDisabled()
                .onSubmit {
                    Task{
                        do {
                            try await model.searchResponseMorty(character: character)
                        } catch {
                            print("Error")
                        }
                    }
                }
        }
        .frame(height: 40)
        .padding(.horizontal)
        .overlay{
            Capsule()
                .stroke(lineWidth: 0.5)
                .foregroundStyle(Color(.systemGray4))
                .shadow(color: .black.opacity(0.4), radius: 2)
        }
        .padding(.horizontal)
    }
}

#Preview {
    MainView()
}
