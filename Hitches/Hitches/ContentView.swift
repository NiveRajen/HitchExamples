//
//  ContentView.swift
//  Hitches
//
//  Created by Nivedha Rajendran on 08.10.24.
//

import SwiftUI

//rendering hitch example
struct ContentView: View {
    let items = Array(1...1000)
    
    var body: some View {
        //        List(items, id: \.self) { item in
        //            ItemView(item: item)
        //        }
        
        //Use Lazy Containers to optimize layouts
        ScrollView {
            LazyVStack() {
                ForEach(items, id: \.self) { item in
                    ItemView(item: item)
                }
            }
        }
    }
}

struct ItemView: View {
    let item: Int
    
    @State private var result: Int = 0
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Item \(item)")
                .font(.headline)
            //This can cause rendering hitches
//            Text("Result: \(expensiveComputation(item))")
            
            Text("Result: \(result)")
                .font(.subheadline)
        }
        .padding()
        .onAppear() {
            //Do expensive calculation or loading images on Appear
            calculateInBackground()
        }
    }
    
    func calculateInBackground() {
        //Do the expensive code asynchronously
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.expensiveComputation(self.item)
            
            //update the value in the main thread
            DispatchQueue.main.async {
                self.result = result
            }
        }
    }
    
    nonisolated func expensiveComputation(_ input: Int) -> Int {
        var result = 0
        
        for i in 1...10_000 {
            result += i * input
        }
        
        return result
    }
}

#Preview {
    ContentView()
}
