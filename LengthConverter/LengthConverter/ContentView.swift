//
//  ContentView.swift
//  LengthConverter
//
//  Created by Jason Yang on 15/06/21.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNumber = ""
    @State private var inputUnit = 2
    @State private var outputUnit = 2
    
    let lengthUnits = ["m", "km", "ft", "yd", "mi"]
    
    var inputToM: Measurement<Dimension> {
        let inputUnitSelection = lengthUnits[inputUnit]
        let inputNumberDouble = Double(inputNumber) ?? 0
        
        switch inputUnitSelection {
        case "km":
            return Measurement(value: inputNumberDouble, unit: UnitLength.kilometers).converted(to: UnitLength.meters)
        case "ft":
            return Measurement(value: inputNumberDouble, unit: UnitLength.feet).converted(to: UnitLength.meters)
        case "yd":
            return Measurement(value: inputNumberDouble, unit: UnitLength.yards).converted(to: UnitLength.meters)
        case "mi":
            return Measurement(value: inputNumberDouble, unit: UnitLength.miles).converted(to: UnitLength.meters)
        default:
            return Measurement(value: inputNumberDouble, unit: UnitLength.meters)
        }
    }
    
    var MToOutput: Double {
        let outputUnitSelection = lengthUnits[outputUnit]
        
        switch outputUnitSelection {
        case "km":
            return inputToM.converted(to: UnitLength.kilometers).value
        case "ft":
            return inputToM.converted(to: UnitLength.feet).value
        case "yd":
            return inputToM.converted(to: UnitLength.yards).value
        case "mi":
            return inputToM.converted(to: UnitLength.miles).value
        default:
            return inputToM.value
        }
        
    }
    
    var result: Double {
        return 10
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input number", text: $inputNumber)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Select input unit")) {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(0 ..< lengthUnits.count) {
                            Text(self.lengthUnits[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Select output unit")) {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(0 ..< lengthUnits.count) {
                            Text(self.lengthUnits[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Result")) {
                    Text("\(MToOutput, specifier: "%.0f")")
                }
            }
            .navigationTitle("Length Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
