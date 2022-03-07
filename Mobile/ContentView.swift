//
//  ContentView.swift
//  Mobile
//
//  Created by m1 on 02/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var logVM : loginVM

    var body: some View {
            /*if logVM.logged {
                AppTabView()
            }else{
                loginView()
            }*/
            
            AppTabView()
            
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
