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
    var body: some View
    {
        ZStack {
            Color.red.ignoresSafeArea( edges: .top)
            Text("First View")
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
