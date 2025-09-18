import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Resumen financiero
                    FinancialSummaryCard(viewModel: viewModel)
                    
                    // Períodos activos
                    ActivePeriodsCard(viewModel: viewModel)
                    
                    // Gastos por categoría (top 5)
                    TopExpensesCard(viewModel: viewModel)
                    
                    // Ingresos recientes
                    RecentIncomeCard(viewModel: viewModel)
                }
                .padding()
            }
            .navigationTitle("Dashboard")
            .refreshable {
                await viewModel.refreshData()
            }
        }
    }
}

struct FinancialSummaryCard: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Resumen Financiero")
                .font(.title2)
                .fontWeight(.semibold)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Ingresos del mes")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(viewModel.monthlyIncome, format: .currency(code: "MXN"))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Gastos del mes")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(viewModel.monthlyExpenses, format: .currency(code: "MXN"))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
            }
            
            Divider()
            
            HStack {
                Text("Balance")
                    .font(.headline)
                Spacer()
                Text(viewModel.monthlyBalance, format: .currency(code: "MXN"))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.monthlyBalance >= 0 ? .green : .red)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    DashboardView()
}
