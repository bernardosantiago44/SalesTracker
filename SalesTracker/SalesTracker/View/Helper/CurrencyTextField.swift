//
//  CurrencyTextField.swift
//  SalesTracker
//
//  Created by Bernardo Santiago Marin on 28/01/24.
//

import SwiftUI

class UICurrencyTextField: UITextField {
    var startingValue: Double? {
        didSet {
            let number = NSNumber(value: startingValue ?? 0)
            self.text = formatter.string(from: number)
        }
    }
    
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.currencySymbol = Locale.current.currencySymbol ?? "$"
        
        return formatter
    }()
}

struct CurrencyTextField: UIViewRepresentable {
    func makeUIView(context: Context) -> UICurrencyTextField {
        let textField = UICurrencyTextField()
        
        textField.placeholder = String(localized: "productprice")
        textField.backgroundColor = .secondarySystemBackground
        textField.clearButtonMode = .whileEditing
        
        return textField
    }
    
    func updateUIView(_ uiView: UICurrencyTextField, context: Context) {
        
    }
    
    typealias UIViewType = UICurrencyTextField
}


struct CurrencyTextFieldView: View {
    var body: some View {
        CurrencyTextField()
            
    }
}

#Preview {
    CurrencyTextField()
}
