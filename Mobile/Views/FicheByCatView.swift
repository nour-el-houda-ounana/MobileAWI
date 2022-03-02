//
//  FicheByCatView.swift
//  Mobile
//
//  Created by m1 on 03/03/2022.
//

import SwiftUI

struct FicheByCatView: View {
    
    @StateObject
    var listeFiches = listeFichesVM()
    
    var categorie = "Dessert"
    
    var fichesOfCategory : [FicheVM] {
        return listeFiches.searchFicheByCategorie(categorie: categorie)
    }
    
    var body: some View {
        VStack {
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)]){
                ForEach(Array(fichesOfCategory.enumerated()), id: \.element.model.id) { index, item in
                    NavigationLink(destination: detailFicheView(fiches: listeFiches, index: index)) {
                        VStack {
                            ZStack(alignment: .bottom) {
                                Image("pic")
                                    .resizable()
                                    .cornerRadius(20)
                                    .frame(width: 180)
                                    .scaledToFit()
                                VStack(alignment: .leading){
                                    Text("\(item.model.intitule)").bold().fontWeight(.heavy).foregroundColor(.black)
                                    Text("Responsable : \(item.model.responsable)")
                                    Text("Catégorie : \(item.model.categorie)")
                                    
                                }
                                .padding()
                                .frame(width: 180, alignment: .leading)
                                .foregroundColor(.white)
                                .background(.ultraThinMaterial)
                                .cornerRadius(20)
                                
                            }
                            .frame(width: 180, height: 250)
                            .shadow(radius: 3)
                        }
                        .navigationTitle("📄 Fiches \(self.categorie)")
                        
                    }
                }
            }
            .padding(.top)
        }
    }
}

struct FicheByCatView_Previews: PreviewProvider {
    static var previews: some View {
        FicheByCatView()
    }
}
