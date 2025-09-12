import SwiftUI

struct TopExpensesCard: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Top Gastos por Categoría")
                .font(.title2)
                .fontWeight(.semibold)
            
            ForEach(Array(viewModel.topExpenses.enumerated()), id: \.element.category) { index, item in
                TopExpenseRowView(
                    rank: index + 1,
                    category: item.category,
                    amount: item.amount
                )
                
                if index < viewModel.topExpenses.count - 1 {
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

struct TopExpenseRowView: View {
    let rank: Int
    let category: ExpenseCategory
    let amount: Double
    
    private var rankColor: Color {
        switch rank {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .orange
        default: return .blue
        }
    }
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(rankColor)
                    .frame(width: 24, height: 24)
                
                Text("\(rank)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            HStack {
                Image(systemName: category.icon)
                    .foregroundColor(Color(category.color))
                    .frame(width: 20)
                
                Text(category.rawValue)
                    .font(.body)
            }
            
            Spacer()
            
            Text(amount, format: .currency(code: "MXN"))
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.red)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TopExpensesCard(viewModel: DashboardViewModel())
}
