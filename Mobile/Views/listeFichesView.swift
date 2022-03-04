//
//  listeFichesView.swift
//  Mobile
//
//  Created by m1 on 18/02/2022.
//

import SwiftUI

struct listeFichesView: View {
    
    @StateObject
    var listeFiches = listeFichesVM()
    
    @State var chercher : String = ""
    
    var searchListe : [FicheVM] {
           if chercher.isEmpty {
               return listeFiches.listeFichesVM
           } else {
               return listeFiches.searchFicheByName(nom: chercher)
           }
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)]){
                ForEach(Array(searchListe.enumerated()), id: \.element.model.id) { index, item in
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
                        .navigationTitle("📄 Fiches Techniques")
                        .searchable(text: $chercher, prompt: "Chercher la fiche")
                    }
                }
                .onAppear() {
                    self.listeFiches.getFiches()
                }
            }
            .padding(.top)
        }
        .padding(.horizontal)
    }

}

struct listeFichesView_Previews: PreviewProvider {
    static var previews: some View {
        listeFichesView()
    }
}
