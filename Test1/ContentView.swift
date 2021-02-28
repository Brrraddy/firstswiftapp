//
//  ContentView.swift
//  Test1
//
//  Created by Annie on 2/27/21.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ??
    false
    
    var body: some View {
        
        VStack{
            
            if status{
                
                Home()
            }
            else{
                
                SignIn()
            }
        }.animation(.spring())
        .onAppear {
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
                
            }
        }
    }
}


struct Home: View {
    
    var body: some View{
        
        VStack{
            
            Text("Home")
            Button(action: {
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name:
                NSNotification.Name("statusChange"), object: nil)
            
            }) {
            
                Text("Logout")
                }
        }
    }
}


struct SignIn : View {
    
    @State var user = ""
    @State var password = ""
    @State var message = ""
    @State var alert = false
    @State var show = false
    
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
                    
                    SignInWithEmail(email: self.user, password: self.password) { (verified, status) in
                        
                        if !verified {
                            
                            self.message = status
                            self.alert.toggle()
                            
                        }
                        else{
                        
                            UserDefaults.standard.set(true, forKey: "status")
                            NotificationCenter.default.post(name:
                                NSNotification.Name("statusChange"), object: nil)
                            
                        }
                    }
                    
                }) {
                    Text("Sign In").foregroundColor(.blue).frame(width: UIScreen.main.bounds.width - 120).padding()
                }.background(Color("color")).clipShape(Capsule()).padding(.top, 45).alert(isPresented: $alert) {
                    
                    Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("Ok")))
                }
                
                Text("(or)").foregroundColor(Color.gray.opacity(0.5)).padding(.top, 30)
                
                HStack(spacing: 8){
                    Text("Dont have any account?").foregroundColor(Color.gray.opacity(0.5))
                    
                    Button(action: {
                        
                    }) {
                        Text("Sign Up")
                        
                    }.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }.padding(.top, 25)
            }.sheet(isPresented: $show) {
                
                SignUp(show: self.$show)
            }
        }
    }
}
    
    
struct SignUp : View {
        
        @State var user = ""
        @State var password = ""
        @State var message = ""
        @State var alert = false
    @Binding var show = Bool
    
        
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
                        
                        SignUpWithEmail(email: self.user, password: self.password) { (verified, status) in
                            
                            if !verified {
                                
                                self.message = status
                                self.alert.toggle()
                                
                            }
                            else{
                            
                                UserDefaults.standard.set(true, forKey: "status")
                                NotificationCenter.default.post(name:
                                    NSNotification.Name("statusChange"), object: nil)
                                
                            }
                        }
                        
                    }) {
                        Text("Sign Up").foregroundColor(.blue).frame(width: UIScreen.main.bounds.width - 120).padding()
                    }.background(Color("color")).clipShape(Capsule()).padding(.top, 45)
                        
                    }.padding()
                        .alert(isPresented: $alert) {
                    
                    Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("Ok")))
                        }
            }
        }
}


func SignUpWithEmail(email: String, password: String, completion: @escaping (Bool, String)->Void){
    
    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
        
        if error != nil{
            
            completion(false,(error?.localizedDescription)!)
            return
        }
        completion(true,(result?.user.email)!)
    }
    
}


func SignInWithEmail(email: String, password: String, completion: @escaping (Bool, String)->Void){
    
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
        
        if error != nil{
            
            completion(false,(error?.localizedDescription)!)
            return
        }
        completion(true,(result?.user.email)!)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
