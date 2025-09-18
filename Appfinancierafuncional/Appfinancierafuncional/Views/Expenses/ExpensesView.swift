import SwiftUI

struct ExpensesView: View {
    @StateObject private var viewModel = ExpensesViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Ingresos mensuales
                    IncomeSectionView(viewModel: viewModel)
                    
                    // Gastos mensuales
                    ExpenseCategoriesSectionView(viewModel: viewModel)
                }
                .padding()
            }
            .navigationTitle("Gastos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.showAddExpense = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showAddExpense) {
                AddExpenseView(viewModel: viewModel)
            }
        }
    }
}

struct IncomeSectionView: View {
    @ObservedObject var viewModel: ExpensesViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "dollarsign.circle.fill")
                    .foregroundColor(.blue)
                Text("Ingresos mensuales")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            HStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("SALARIO NETO")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField("Importe", value: $viewModel.netSalary, format: .currency(code: "MXN"))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading) {
                    Text("OTROS INGRESOS")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField("Importe", value: $viewModel.otherIncome, format: .currency(code: "MXN"))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct ExpenseCategoriesSectionView: View {
    @ObservedObject var viewModel: ExpensesViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Gastos mensuales")
                .font(.title2)
                .fontWeight(.semibold)
            
            // Fijos obligatorios
            ExpenseCategoryCard(
                title: "Fijos obligatorios",
                icon: "exclamationmark.triangle.fill",
                color: .red,
                categories: ExpenseCategory.allCases.filter { $0.isMandatory },
                viewModel: viewModel
            )
            
            // Fijos reducibles
            ExpenseCategoryCard(
                title: "Fijos reducibles",
                icon: "gear.circle.fill",
                color: .blue,
                categories: ExpenseCategory.allCases.filter { $0.isReducible },
                viewModel: viewModel
            )
            
            // Variables
            ExpenseCategoryCard(
                title: "Variables",
                icon: "chart.line.uptrend.xyaxis",
                color: .orange,
                categories: ExpenseCategory.allCases.filter { $0.isVariable },
                viewModel: viewModel
            )
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    ExpensesView()
}
