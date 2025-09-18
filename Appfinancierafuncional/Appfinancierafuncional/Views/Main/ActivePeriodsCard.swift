import SwiftUI

struct ActivePeriodsCard: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Períodos Activos")
                .font(.title2)
                .fontWeight(.semibold)
            
            ForEach(viewModel.activePeriods) { period in
                PeriodRowView(period: period)
                
                if period.id != viewModel.activePeriods.last?.id {
                    Divider()
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct PeriodRowView: View {
    let period: FinancialPeriod
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(period.type.rawValue)
                    .font(.headline)
                Text("\(period.startDate.reportFormat) - \(period.endDate.reportFormat)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(period.balance, format: .currency(code: "MXN"))
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(period.balance >= 0 ? .green : .red)
                
                HStack(spacing: 8) {
                    Text("I: \(period.totalIncome, format: .currency(code: "MXN"))")
                        .font(.caption)
                        .foregroundColor(.green)
                    
                    Text("G: \(period.totalExpenses, format: .currency(code: "MXN"))")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ActivePeriodsCard(viewModel: DashboardViewModel())
}
