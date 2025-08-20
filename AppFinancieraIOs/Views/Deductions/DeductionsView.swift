import SwiftUI

struct DeductionsView: View {
    @StateObject private var viewModel = DeductionsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section("Resumen de deducciones") {
                    DeductionSummaryCard(viewModel: viewModel)
                }
                
                Section("Deducciones del mes") {
                    ForEach(viewModel.deductions) { deduction in
                        DeductionRowView(deduction: deduction)
                    }
                    .onDelete(perform: deleteDeduction)
                }
                
                Section("Cálculo automático") {
                    if let taxCalculation = viewModel.currentTaxCalculation {
                        AutomaticTaxCalculationView(taxCalculation: taxCalculation)
                    }
                }
            }
            .navigationTitle("Deducciones")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.showAddDeduction = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showAddDeduction) {
                AddDeductionView(viewModel: viewModel)
            }
        }
    }
    
    private func deleteDeduction(offsets: IndexSet) {
        viewModel.deleteDeduction(at: offsets)
    }
}

struct DeductionSummaryCard: View {
    @ObservedObject var viewModel: DeductionsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Total de deducciones del mes")
                .font(.headline)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("ISR")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(viewModel.totalISR, format: .currency(code: "MXN"))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                VStack(alignment: .center) {
                    Text("IMSS")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(viewModel.totalIMSS, format: .currency(code: "MXN"))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Otros")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(viewModel.totalOtherDeductions, format: .currency(code: "MXN"))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
            }
            
            Divider()
            
            HStack {
                Text("Total")
                    .font(.headline)
                Spacer()
                Text(viewModel.totalDeductions, format: .currency(code: "MXN"))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct DeductionRowView: View {
    let deduction: Deduction
    
    var body: some View {
        HStack {
            Image(systemName: deduction.type.icon)
                .foregroundColor(.red)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(deduction.type.rawValue)
                    .font(.headline)
                if let description = deduction.description {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Text(deduction.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(deduction.amount, format: .currency(code: "MXN"))
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                
                if let percentage = deduction.percentage {
                    Text("\(percentage, specifier: "%.2f")%")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct AutomaticTaxCalculationView: View {
    let taxCalculation: TaxCalculation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Cálculo automático basado en ingresos")
                .font(.headline)
            
            HStack {
                Text("Ingreso bruto")
                Spacer()
                Text(taxCalculation.grossSalary, format: .currency(code: "MXN"))
            }
            
            HStack {
                Text("ISR calculado")
                Spacer()
                Text(taxCalculation.totalISR, format: .currency(code: "MXN"))
                    .foregroundColor(.red)
            }
            
            HStack {
                Text("IMSS calculado")
                Spacer()
                Text(taxCalculation.imss, format: .currency(code: "MXN"))
                    .foregroundColor(.red)
            }
            
            HStack {
                Text("Salario neto")
                Spacer()
                Text(taxCalculation.netSalary, format: .currency(code: "MXN"))
                    .foregroundColor(.green)
                    .fontWeight(.semibold)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    DeductionsView()
}
