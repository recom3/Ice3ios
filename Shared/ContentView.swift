//
//  ContentView.swift
//  Shared
//
//  Created by recom3 on 18.03.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //Text("Hello, world!")
        //    .padding()
        TabView {
            FirstView().tabItem{Text("1st")};
            
            SecondView().tabItem{Text("2nd")};
            
            ThirdView().tabItem{Text("3rd")};

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FirstView: View
{
    @State private var showLogin = false
    
    var body: some View
    {
        ZStack {
            Color.red.ignoresSafeArea( edges: .top)
            VStack {
                Text("First View")
                Button(action: {
                    showLogin.toggle()
                }) {
                    Text("Login")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.red)
                        .cornerRadius(8)
                }
            }
            .sheet(isPresented: $showLogin) {
                LoginView()
            }
        }
    }
}

struct SecondView: View
{
    var body: some View
    {
        ZStack {
            Color.green.ignoresSafeArea( edges: .top)
            Text("Second View")
        }
    }
}

struct ThirdView: View
{
    var body: some View
    {
        ZStack {
            Color.blue.ignoresSafeArea( edges: .top)
            Text("Third View")
        }
    }
}

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginStatus: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
            TextField("Username", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.bottom, 20)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.bottom, 20)

            Button(action: {
                login();
            }) {
                Text("Login")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
    
    func login() {
        let webService = WebService()
        let urlString = "https://www.recom3.com/api/login"
        let jsonPayload: [String: Any] = ["username": username, "password": password]

        webService.postRequest(urlString: urlString, jsonPayload: jsonPayload) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    loginStatus = "Login Successful"
                    // Dismiss the view after a successful login
                    self.presentationMode.wrappedValue.dismiss()
                case .failure(let error):
                    loginStatus = "Login Failed: \(error.localizedDescription)"
                }
            }
        }
    }
}
