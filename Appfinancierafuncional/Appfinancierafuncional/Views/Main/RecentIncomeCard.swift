import SwiftUI

struct RecentIncomeCard: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Ingresos Recientes")
                .font(.title2)
                .fontWeight(.semibold)
            
            ForEach(viewModel.recentIncome) { income in
                RecentIncomeRowView(income: income)
                
                if income.id != viewModel.recentIncome.last?.id {
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

struct RecentIncomeRowView: View {
    let income: Income
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(income.description)
                    .font(.headline)
                    .lineLimit(1)
                
                HStack {
                    Text(income.type.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                    
                    if income.isRecurring {
                        Text(income.recurringPeriod?.rawValue ?? "")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(income.netAmount, format: .currency(code: "MXN"))
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                
                Text(income.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    RecentIncomeCard(viewModel: DashboardViewModel())
}
