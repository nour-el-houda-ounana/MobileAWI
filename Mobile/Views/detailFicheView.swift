//
//  detailFicheView.swift
//  Mobile
//
//  Created by m1 on 18/02/2022.
//

import SwiftUI

struct detailFicheView: View {
    
    //@ObservedObject var fiche : FicheVM
    
    @ObservedObject
    var fiches : listeFichesVM
    
    var index : Int

    var body: some View {
        ScrollView {
            Image("pic")
                 .resizable()
                 .aspectRatio(contentMode: .fill)
                 .frame(height: 70)
                 .background(LinearGradient(gradient:  Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                        
            Text(fiches.listeFichesVM[index].model.intitule)
                .font(.largeTitle)
                .bold()
                .padding()
                .foregroundColor(.black)

            Spacer().frame(height: 25)
            
            VStack(alignment: .trailing) {
                Button {
                        //imprimer
                    
                } label: {
                    Image(systemName: "printer.filled.and.paper")
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(50)
                }
                
            }
                        
            VStack (alignment: .leading){
                HStack {
                    HStack {
                        Text("Responsable : ")
                                .fontWeight(.medium)
                                .padding(.vertical,8)
                                .font(.title3)
                        Text(fiches.listeFichesVM[index].model.responsable)
                    }
                    Spacer().frame(width : 25)
                    Text("Couverts : ")
                            .fontWeight(.medium)
                            .padding(.vertical,8)
                            .font(.title3)
                    Text("\(fiches.listeFichesVM[index].model.couverts)")
                    
                }
                /*HStack {
                    Text("Nombre de couverts : ")
                            .fontWeight(.medium)
                            .padding(.vertical,8)
                            .font(.title3)
                    Text("\(fiches.listeFichesVM[index].model.couverts)")
                }*/
                
                if (fiches.listeFichesVM[index].model.materielDress != "") {
                    HStack {
                        Text("Materiel de dressage : ")
                                .fontWeight(.medium)
                                .padding(.vertical,8)
                                .font(.title3)
                        Text(fiches.listeFichesVM[index].model.materielDress)
                    }
                }
                
                if (fiches.listeFichesVM[index].model.materielSpes != "") {
                   HStack {
                        Text("Matériel spécifique : ")
                                .fontWeight(.medium)
                                .padding(.vertical,8)
                                .font(.title3)
                       Text("\(fiches.listeFichesVM[index].model.materielSpes)")
                    }
                }
            }
            .padding()
        }
        .ignoresSafeArea(.container, edges: .top)


    }
}


struct detailFicheView_Previews: PreviewProvider {
    static var previews: some View {
        let liste = listeFichesVM()
        detailFicheView(fiches: liste, index: 0);
    }
}
