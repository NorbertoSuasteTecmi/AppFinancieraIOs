import SwiftUI

struct AddExpenseView: View {
    @ObservedObject var viewModel: ExpensesViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedCategory: ExpenseCategory = .food
    @State private var amount: Double = 0.0
    @State private var description: String = ""
    @State private var date = Date()
    @State private var isRecurring = false
    @State private var selectedRecurringPeriod: Expense.RecurringPeriod = .monthly
    @State private var notes: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Detalles del gasto") {
                    Picker("Categoría", selection: $selectedCategory) {
                        ForEach(ExpenseCategory.allCases, id: \.self) { category in
                            HStack {
                                Image(systemName: category.icon)
                                    .foregroundColor(Color(category.color))
                                Text(category.rawValue)
                            }
                            .tag(category)
                        }
                    }
                    
                    HStack {
                        Text("Monto")
                        Spacer()
                        TextField("0.00", value: $amount, format: .currency(code: "MXN"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    TextField("Descripción", text: $description)
                    
                    DatePicker("Fecha", selection: $date, displayedComponents: .date)
                }
                
                Section("Opciones adicionales") {
                    Toggle("Gasto recurrente", isOn: $isRecurring)
                    
                    if isRecurring {
                        Picker("Período", selection: $selectedRecurringPeriod) {
                            ForEach(Expense.RecurringPeriod.allCases, id: \.self) { period in
                                Text(period.rawValue).tag(period)
                            }
                        }
                    }
                    
                    TextField("Notas adicionales", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Agregar Gasto")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        saveExpense()
                    }
                    .disabled(amount <= 0)
                }
            }
        }
    }
    
    private func saveExpense() {
        let expense = Expense(
            amount: amount,
            category: selectedCategory,
            date: date,
            description: description.isEmpty ? selectedCategory.rawValue : description,
            isRecurring: isRecurring,
            recurringPeriod: isRecurring ? selectedRecurringPeriod : nil,
            notes: notes.isEmpty ? nil : notes
        )
        
        viewModel.addExpense(expense)
        dismiss()
    }
}

#Preview {
    AddExpenseView(viewModel: ExpensesViewModel())
}
