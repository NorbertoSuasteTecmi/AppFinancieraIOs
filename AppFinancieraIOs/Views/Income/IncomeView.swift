import SwiftUI

struct IncomeView: View {
    @StateObject private var viewModel = IncomeViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section("Ingresos del mes") {
                    ForEach(viewModel.incomes) { income in
                        IncomeRowView(income: income)
                    }
                    .onDelete(perform: deleteIncome)
                }
                
                Section("Resumen fiscal") {
                    if let taxCalculation = viewModel.currentTaxCalculation {
                        TaxCalculationRowView(taxCalculation: taxCalculation)
                    }
                }
                
                Section("Total del mes") {
                    HStack {
                        Text("Ingresos brutos")
                        Spacer()
                        Text(viewModel.totalGrossIncome, format: .currency(code: "MXN"))
                            .fontWeight(.semibold)
                    }
                    
                    HStack {
                        Text("Ingresos netos")
                        Spacer()
                        Text(viewModel.totalNetIncome, format: .currency(code: "MXN"))
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                    }
                }
            }
            .navigationTitle("Ingresos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.showAddIncome = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showAddIncome) {
                AddIncomeView(viewModel: viewModel)
            }
        }
    }
    
    private func deleteIncome(offsets: IndexSet) {
        viewModel.deleteIncome(at: offsets)
    }
}

struct IncomeRowView: View {
    let income: Income
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading) {
                    Text(income.description)
                        .font(.headline)
                    Text(income.type.rawValue)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(income.netAmount, format: .currency(code: "MXN"))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                    Text("Bruto: \(income.grossAmount, format: .currency(code: "MXN"))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            HStack {
                Text(income.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if income.isRecurring {
                    Spacer()
                    Text(income.recurringPeriod?.rawValue ?? "")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct TaxCalculationRowView: View {
    let taxCalculation: TaxCalculation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Cálculo fiscal - \(taxCalculation.date, style: .date)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack {
                Text("ISR")
                Spacer()
                Text(taxCalculation.totalISR, format: .currency(code: "MXN"))
                    .foregroundColor(.red)
            }
            
            HStack {
                Text("IMSS")
                Spacer()
                Text(taxCalculation.imss, format: .currency(code: "MXN"))
                    .foregroundColor(.red)
            }
            
            HStack {
                Text("Subsidio")
                Spacer()
                Text(taxCalculation.employmentSubsidy, format: .currency(code: "MXN"))
                    .foregroundColor(.green)
            }
            
            Divider()
            
            HStack {
                Text("Salario neto")
                    .fontWeight(.semibold)
                Spacer()
                Text(taxCalculation.netSalary, format: .currency(code: "MXN"))
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            }
        }
    }
}

#Preview {
    IncomeView()
}
