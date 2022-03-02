//
//  CategoriesView.swift
//  Mobile
//

//  Created by m1 on 15/02/2022.
//

import SwiftUI
import Firebase

struct CategoriesView: View {

    @ObservedObject
    var CatModel = CatFicheVM()
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)]){
                    
                    ForEach(CatModel.listCat){ item in
                        NavigationLink (destination: FicheByCatView(categorie: item.type)) {
                            VStack {
                                Image("\(item.image)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .overlay(alignment: .center) {
                                        VStack {
                                            //Text("\(item.emoji)").bold()
                                            Text("\(item.type)")
                                                .bold()
                                                .font(.title)
                                                .foregroundColor(.black)
                                                .shadow(color: .black, radius: 3, x: 0, y: 0)
                                                .frame(maxWidth: 136)
                                                .padding()
                                            
                                        }
                                        
                                    }
                            }
                            .frame(width: 160, height: 217, alignment: .top)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                            .clipShape(RoundedRectangle(cornerRadius: 20,style: .continuous))
                            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 0)
                                                    
                            .navigationTitle("🍽️ Catégories")
                            
                        }
                    
                    }
                    
                }
                .padding(.top)
            }
            .padding(.horizontal)
        }
    }
    
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
