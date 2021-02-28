//
//  ContentView.swift
//  Test1
//
//  Created by Annie on 2/27/21.
//

import SwiftUI
import FirebaseCore

struct ContentView: View {
    var body: some View {
        SignIn()
    }
}

struct SignIn : View {
    
    @State var user = ""
    @State var password = ""
    
    var body : some View {
        VStack{
            Text("Sign In")
                .fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom], 20)
            VStack{
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        
                        Text("Username")
                            .font(.headline)
                            .fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        
                        HStack{
                            TextField("Enter your username", text: $user)
                            
                            if user != ""{
                                Image("check")
                            }
                        }
                        
                        Divider()
                    }.padding(.bottom, 15)
                    VStack(alignment: .leading){
                        Text("Password")
                            .font(.headline)
                            .fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        
                        SecureField("Enter your password", text: $password)
                        
                        Divider()
                    }
                }.padding(.horizontal, 6)
            }.padding()
            VStack{
                Button(action: {
                    
                }) {
                    Text("Sing In").foregroundColor(.blue).frame(width: UIScreen.main.bounds.width - 120).padding()
                }.background(Color("color")).clipShape(Capsule()).padding(.top, 45)
                
                Text("(or)").foregroundColor(Color.gray.opacity(0.5)).padding(.top, 30)
                
                HStack(spacing: 8){
                    Text("Dont have any account?").foregroundColor(Color.gray.opacity(0.5))
                    
                    Button(action: {
                        
                    }) {
                        Text("Sing Up")
                        
                    }.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }.padding(.top, 25)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
