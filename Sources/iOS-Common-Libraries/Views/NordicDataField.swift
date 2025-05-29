//
//  NordicDataField.swift
//  nRF-Connect
//  iOSCommonLibraries
//
//  Created by Dinesh Harjani on 5/10/23.
//  Created by Dinesh Harjani on 29/5/25.
//  Copyright © 2025 Nordic Semiconductor. All rights reserved.
//

import SwiftUI

// MARK: - NordicDataField

public struct NordicDataField: View {
    
    // MARK: Properties
    
    @Binding private var data: Data
    @Binding private var selectedParser: CommonDataParser
    @State private var dataBool: Bool
    @State private var dataString: String
    private let dataParsers: [CommonDataParser]
    private let dataParserPickerEnabled: Bool
    
    // MARK: Init
    
    init(data: Binding<Data>, dataParser: Binding<CommonDataParser>,
         dataParsers: [CommonDataParser], parserIsUserSelectable: Bool = true) {
        self._data = data
        self._selectedParser = dataParser
        self.dataBool = false
        self.dataString = dataParser.wrappedValue(data.wrappedValue) ?? ""
        self.dataParsers = dataParsers
        self.dataParserPickerEnabled = parserIsUserSelectable
    }
    
    // MARK: View
    
    public var body: some View {
        if selectedParser == .boolean {
            Toggle(dataBool ? "True (0x1)" : "False (0x0)", isOn: $dataBool)
                .onChange(of: dataBool) { newValue in
                    data = Data(repeating: newValue ? 1 : 0, count: 1)
                }
        } else {
            TextField("", text: $dataString)
                .padding(4)
                #if os(iOS) || targetEnvironment(macCatalyst)
                .background(Color(.systemGray6))
                #else
                .background(Color.secondarySystemBackground)
                #endif
                .cornerRadius(8)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .onChange(of: dataString) { newString in
                    switch selectedParser {
                    case .byteArray:
                        data = Data(hexString: newString) ?? Data()
                    case .unsignedInt:
                        guard let number = UInt8(newString) else { return }
                        data = Data(repeating: number, count: 1)
                    case .boolean:
                        // No-op, because the Toggle should be visible.
                        data = Data()
                    case .utf8:
                        data = newString.data(using: .utf8) ?? Data()
                    default:
                        return
                    }
                }
        }
        
        InlineSegmentedControlPicker(selectedValue: $selectedParser, possibleValues: dataParsers)
            .disabled(!dataParserPickerEnabled)
    }
}
