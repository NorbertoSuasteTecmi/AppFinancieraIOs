//
//  ContentView.swift
//  Appfinancierafuncional
//
//  Created by Alumno on 11/09/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }
            
            IncomeView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Ingresos")
                }
            
            ExpensesView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Gastos")
                }
            
            DeductionsView()
                .tabItem {
                    Image(systemName: "percent")
                    Text("Deducciones")
                }
            
            ReportsView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Reportes")
                }
        }
        .accentColor(.blue)
    }
}

#Preview {
    ContentView()
}
