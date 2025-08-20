import SwiftUI

struct AddDeductionView: View {
    @ObservedObject var viewModel: DeductionsViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedType: Deduction.DeductionType = .isr
    @State private var amount: Double = 0.0
    @State private var percentage: Double = 0.0
    @State private var date = Date()
    @State private var description: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Detalles de la deducción") {
                    Picker("Tipo de deducción", selection: $selectedType) {
                        ForEach(Deduction.DeductionType.allCases, id: \.self) { type in
                            HStack {
                                Image(systemName: type.icon)
                                Text(type.rawValue)
                            }
                            .tag(type)
                        }
                    }
                    
                    HStack {
                        Text("Monto")
                        Spacer()
                        TextField("0.00", value: $amount, format: .currency(code: "MXN"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Porcentaje")
                        Spacer()
                        TextField("0.00", value: $percentage, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    DatePicker("Fecha", selection: $date, displayedComponents: .date)
                    
                    TextField("Descripción (opcional)", text: $description)
                }
                
                if amount > 0 {
                    Section("Resumen") {
                        HStack {
                            Text("Tipo")
                            Spacer()
                            Text(selectedType.rawValue)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("Monto")
                            Spacer()
                            Text(amount, format: .currency(code: "MXN"))
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                        }
                        
                        if percentage > 0 {
                            HStack {
                                Text("Porcentaje")
                                Spacer()
                                Text("\(percentage, specifier: "%.2f")%")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Agregar Deducción")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        saveDeduction()
                    }
                    .disabled(amount <= 0)
                }
            }
        }
    }
    
    private func saveDeduction() {
        let deduction = Deduction(
            type: selectedType,
            amount: amount,
            percentage: percentage > 0 ? percentage : nil,
            date: date,
            description: description.isEmpty ? nil : description
        )
        
        viewModel.addDeduction(deduction)
        dismiss()
    }
}

#Preview {
    AddDeductionView(viewModel: DeductionsViewModel())
}
