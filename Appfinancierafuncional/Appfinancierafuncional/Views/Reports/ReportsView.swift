import SwiftUI

struct ReportsView: View {
    @StateObject private var viewModel = ReportsViewModel()
    @State private var selectedPeriod: FinancialPeriod.PeriodType = .monthly
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Selector de período
                    PeriodSelectorView(selectedPeriod: $selectedPeriod)
                    
                    // Resumen del período
                    PeriodSummaryCard(viewModel: viewModel, periodType: selectedPeriod)
                    
                    // Gráficas
                    ChartsSectionView(viewModel: viewModel, periodType: selectedPeriod)
                    
                    // Análisis de gastos por categoría
                    ExpensesByCategoryCard(viewModel: viewModel, periodType: selectedPeriod)
                    
                    // Comparativa de períodos
                    PeriodComparisonCard(viewModel: viewModel)
                }
                .padding()
            }
            .navigationTitle("Reportes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.exportReport() }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        }
    }
}

struct PeriodSelectorView: View {
    @Binding var selectedPeriod: FinancialPeriod.PeriodType
    
    var body: some View {
        Picker("Período", selection: $selectedPeriod) {
            ForEach(FinancialPeriod.PeriodType.allCases, id: \.self) { period in
                Text(period.rawValue).tag(period)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
    }
}

struct PeriodSummaryCard: View {
    @ObservedObject var viewModel: ReportsViewModel
    let periodType: FinancialPeriod.PeriodType
    
    private var periodData: FinancialPeriod? {
        viewModel.getCurrentPeriodData(for: periodType)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Resumen del período \(periodType.rawValue.lowercased())")
                .font(.title2)
                .fontWeight(.semibold)
            
            if let data = periodData {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Ingresos")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(data.totalIncome, format: .currency(code: "MXN"))
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .center) {
                        Text("Gastos")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(data.totalExpenses, format: .currency(code: "MXN"))
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("Balance")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(data.balance, format: .currency(code: "MXN"))
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(data.balance >= 0 ? .green : .red)
                    }
                }
                
                HStack {
                    Text("Período")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(data.startDate, style: .date)
                        .font(.caption)
                    Text("-")
                        .font(.caption)
                    Text(data.endDate, style: .date)
                        .font(.caption)
                }
            } else {
                Text("No hay datos disponibles para este período")
                    .foregroundColor(.secondary)
                    .italic()
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct ChartsSectionView: View {
    @ObservedObject var viewModel: ReportsViewModel
    let periodType: FinancialPeriod.PeriodType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Gráficas")
                .font(.title2)
                .fontWeight(.semibold)
            
            // Gráfica de ingresos vs gastos
            IncomeVsExpensesChart(viewModel: viewModel, periodType: periodType)
            
            // Gráfica de gastos por categoría
            ExpensesByCategoryChart(viewModel: viewModel, periodType: periodType)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct IncomeVsExpensesChart: View {
    @ObservedObject var viewModel: ReportsViewModel
    let periodType: FinancialPeriod.PeriodType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Ingresos vs Gastos")
                .font(.headline)
            
            // Aquí iría la implementación de Charts (iOS 16+)
            // Por ahora mostramos un placeholder
            HStack {
                VStack {
                    Text("Ingresos")
                        .font(.caption)
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 60, height: 100)
                    Text("$25,000")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                
                VStack {
                    Text("Gastos")
                        .font(.caption)
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 60, height: 60)
                    Text("$15,000")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            .frame(height: 120)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

struct ExpensesByCategoryChart: View {
    @ObservedObject var viewModel: ReportsViewModel
    let periodType: FinancialPeriod.PeriodType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Gastos por Categoría")
                .font(.headline)
            
            // Placeholder para gráfica de dona
            ZStack {
                Circle()
                    .stroke(Color.blue, lineWidth: 20)
                    .frame(width: 100, height: 100)
                
                Circle()
                    .stroke(Color.red, lineWidth: 20)
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(-90))
                
                Circle()
                    .stroke(Color.orange, lineWidth: 20)
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(90))
                
                VStack {
                    Text("Total")
                        .font(.caption)
                    Text("$15,000")
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
            .frame(height: 120)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

struct ExpensesByCategoryCard: View {
    @ObservedObject var viewModel: ReportsViewModel
    let periodType: FinancialPeriod.PeriodType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Gastos por Categoría")
                .font(.title2)
                .fontWeight(.semibold)
            
            ForEach(ExpenseCategory.allCases.prefix(8), id: \.self) { category in
                HStack {
                    Image(systemName: category.icon)
                        .foregroundColor(Color(category.color))
                        .frame(width: 30)
                    
                    Text(category.rawValue)
                        .font(.body)
                    
                    Spacer()
                    
                    Text(viewModel.getCategoryAmount(category, for: periodType), format: .currency(code: "MXN"))
                        .font(.body)
                        .fontWeight(.semibold)
                }
                
                if category != ExpenseCategory.allCases.prefix(8).last {
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

struct PeriodComparisonCard: View {
    @ObservedObject var viewModel: ReportsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Comparativa de Períodos")
                .font(.title2)
                .fontWeight(.semibold)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Semana anterior")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("$5,200")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                
                Spacer()
                
                VStack(alignment: .center) {
                    Text("Quincena anterior")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("$12,800")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Mes anterior")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("$24,500")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    ReportsView()
}
