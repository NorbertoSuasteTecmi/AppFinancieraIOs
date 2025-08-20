import SwiftUI

struct AddIncomeView: View {
    @ObservedObject var viewModel: IncomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var grossAmount: Double = 0.0
    @State private var netAmount: Double = 0.0
    @State private var selectedType: Income.IncomeType = .freelance
    @State private var description: String = ""
    @State private var date = Date()
    @State private var isRecurring = false
    @State private var selectedRecurringPeriod: Income.RecurringPeriod = .monthly
    @State private var showTaxCalculation = false
    
    var body: some View {
        NavigationView {
            Form {
                Section("Detalles del ingreso") {
                    HStack {
                        Text("Monto bruto")
                        Spacer()
                        TextField("0.00", value: $grossAmount, format: .currency(code: "MXN"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Monto neto")
                        Spacer()
                        TextField("0.00", value: $netAmount, format: .currency(code: "MXN"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    Picker("Tipo de ingreso", selection: $selectedType) {
                        ForEach(Income.IncomeType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    
                    TextField("Descripción", text: $description)
                    
                    DatePicker("Fecha", selection: $date, displayedComponents: .date)
                }
                
                Section("Opciones adicionales") {
                    Toggle("Ingreso recurrente", isOn: $isRecurring)
                    
                    if isRecurring {
                        Picker("Período", selection: $selectedRecurringPeriod) {
                            ForEach(Income.RecurringPeriod.allCases, id: \.self) { period in
                                Text(period.rawValue).tag(period)
                            }
                        }
                    }
                }
                
                if grossAmount > 0 && netAmount > 0 {
                    Section("Resumen") {
                        HStack {
                            Text("Deducciones totales")
                            Spacer()
                            Text(grossAmount - netAmount, format: .currency(code: "MXN"))
                                .foregroundColor(.red)
                        }
                        
                        Button("Ver cálculo fiscal detallado") {
                            showTaxCalculation = true
                        }
                        .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Agregar Ingreso")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        saveIncome()
                    }
                    .disabled(grossAmount <= 0 || netAmount <= 0)
                }
            }
            .sheet(isPresented: $showTaxCalculation) {
                TaxCalculationDetailView(grossSalary: grossAmount)
            }
        }
    }
    
    private func saveIncome() {
        let income = Income(
            grossAmount: grossAmount,
            netAmount: netAmount,
            date: date,
            type: selectedType,
            description: description.isEmpty ? selectedType.rawValue : description,
            isRecurring: isRecurring,
            recurringPeriod: isRecurring ? selectedRecurringPeriod : nil
        )
        
        viewModel.addIncome(income)
        dismiss()
    }
}

struct TaxCalculationDetailView: View {
    let grossSalary: Double
    @Environment(\.dismiss) private var dismiss
    
    private var taxCalculation: TaxCalculation {
        TaxCalculation(grossSalary: grossSalary)
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Desglose del cálculo fiscal") {
                    DetailRow(title: "Sueldo bruto", value: taxCalculation.grossSalary, color: .primary)
                    DetailRow(title: "Límite inferior", value: taxCalculation.lowerLimit, color: .secondary)
                    DetailRow(title: "Excedente del límite inferior", value: taxCalculation.excessOverLowerLimit, color: .secondary)
                    DetailRow(title: "Porcentaje sobre excedente", value: taxCalculation.marginalPercentage, color: .secondary, isPercentage: true)
                    DetailRow(title: "Impuesto marginal", value: taxCalculation.marginalTax, color: .red)
                    DetailRow(title: "Cuota fija del impuesto", value: taxCalculation.fixedTaxQuota, color: .red)
                    DetailRow(title: "ISR", value: -taxCalculation.totalISR, color: .red)
                    DetailRow(title: "IMSS", value: -taxCalculation.imss, color: .red)
                    DetailRow(title: "Subsidio al empleo", value: taxCalculation.employmentSubsidy, color: .green)
                }
                
                Section("Resultado") {
                    DetailRow(title: "Salario neto", value: taxCalculation.netSalary, color: .green, isBold: true)
                }
            }
            .navigationTitle("Cálculo Fiscal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cerrar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: Double
    let color: Color
    var isPercentage: Bool = false
    var isBold: Bool = false
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(isBold ? .bold : .regular)
            Spacer()
            if isPercentage {
                Text("\(value, specifier: "%.2f")%")
                    .foregroundColor(color)
                    .fontWeight(isBold ? .bold : .regular)
            } else {
                Text(value, format: .currency(code: "MXN"))
                    .foregroundColor(color)
                    .fontWeight(isBold ? .bold : .regular)
            }
        }
    }
}

#Preview {
    AddIncomeView(viewModel: IncomeViewModel())
}
