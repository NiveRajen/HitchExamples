//
//  CommitHitches.swift
//  Hitches
//
//  Created by Nivedha Rajendran on 08.10.24.
//

import SwiftUI

//commit hitch example
struct CommitHitches: View {
    @State private var sliderValue: Double = 0.0
    
    @State private var committedSliderValue: Double = 0.0
    var body: some View {
        ScrollView {
            LazyVStack() {
                //Slider updates value frequently
                Slider(value: $sliderValue, in: 0...100)
                
                //instead of updating complex layout on every minor change of slider value, we can update less frequently by using .onchange()- this avoids re-rendering
                
                //ComplexLayoutView(sliderValue: sliderValue)
                    .onChange(of: sliderValue, { oldValue, newValue in
                        //Dispatchqueue here have delay to ensure the view wasn't updated excessively during rapid sliding
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            committedSliderValue = newValue
                        }
                    })
                
                ComplexLayoutView(sliderValue: committedSliderValue)
                    
            }
        }
    }
    
}

struct ComplexLayoutView: View {
    let sliderValue: Double
    
    var body: some View {
        //Complex Layout simulation
        VStack {
            ForEach(0..<100, id: \.self) { _ in
                HStack {
                    //Every change in sliderValue causes this value to update - frequent state updates, heavy layout calculation
                    Text("Slider Value: \(sliderValue)")
                        .padding()
                }
            }
        }
    }
}


#Preview {
    CommitHitches()
}
