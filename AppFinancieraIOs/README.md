# FreeTxs 

Una aplicación iOS completa para la gestión de finanzas personales, diseñada específicamente para freelancers y profesionales independientes. La app incluye cálculo automático de deducciones fiscales mexicanas, gestión de gastos por categorías, y reportes periódicos.

##  Características Principales

### Gestión de Ingresos
- Captura de ingresos brutos y netos
- Cálculo automático de deducciones fiscales (ISR, IMSS)
- Soporte para ingresos recurrentes
- Diferentes tipos de ingreso (freelance, empleo, inversión)

###  Cálculo de Deducciones Fiscales
- **ISR (Impuesto sobre la Renta)**: Cálculo progresivo automático
- **IMSS**: Contribuciones al seguro social
- **Subsidio al empleo**: Aplicación automática según tablas del SAT
- Desglose detallado de cálculos fiscales

###  Gestión de Gastos
- **Categorías organizadas**:
  - **Fijos obligatorios**: Renta, préstamos, impuestos
  - **Fijos reducibles**: Servicios básicos, alimentación, transporte
  - **Variables**: Ocio, viajes, suscripciones
- Captura de gastos con fecha y descripción
- Gastos recurrentes con diferentes períodos
- Sistema de categorización automática

###  Reportes y Gráficas
- **Períodos de corte**: 7, 15 y 30 días
- Gráficas comparativas de ingresos vs gastos
- Análisis de gastos por categoría
- Comparativas entre períodos
- Exportación de reportes

###  Interfaz de Usuario
- Diseño moderno con SwiftUI
- Navegación por pestañas intuitiva
- Formularios optimizados para iOS
- Soporte para modo oscuro/claro

##  Arquitectura del Proyecto

```
AppFinancieraIOs/
├── App/                          # Punto de entrada de la aplicación
│   └── AppFinancieraIOsApp.swift
├── Models/                       # Modelos de datos
│   ├── Income.swift             # Modelo de ingresos
│   ├── Deduction.swift          # Modelo de deducciones
│   ├── TaxCalculation.swift     # Cálculos fiscales
│   ├── ExpenseCategory.swift    # Categorías de gastos
│   ├── Expense.swift            # Modelo de gastos
│   └── FinancialPeriod.swift    # Períodos financieros
├── Views/                        # Vistas de la interfaz
│   ├── Main/                    # Vistas principales
│   │   ├── ContentView.swift    # Vista raíz con navegación
│   │   └── DashboardView.swift  # Dashboard principal
│   ├── Income/                  # Vistas de ingresos
│   │   ├── IncomeView.swift     # Lista de ingresos
│   │   └── AddIncomeView.swift  # Agregar ingreso
│   ├── Expenses/                # Vistas de gastos
│   │   ├── ExpensesView.swift   # Vista principal de gastos
│   │   ├── ExpenseCategoryCard.swift # Tarjetas de categorías
│   │   └── AddExpenseView.swift # Agregar gasto
│   ├── Deductions/              # Vistas de deducciones
│   │   ├── DeductionsView.swift # Lista de deducciones
│   │   └── AddDeductionView.swift # Agregar deducción
│   └── Reports/                 # Vistas de reportes
│       └── ReportsView.swift    # Reportes y gráficas
├── ViewModels/                   # Lógica de negocio
│   ├── DashboardViewModel.swift # Dashboard
│   ├── IncomeViewModel.swift    # Gestión de ingresos
│   ├── ExpensesViewModel.swift  # Gestión de gastos
│   ├── DeductionsViewModel.swift # Gestión de deducciones
│   └── ReportsViewModel.swift   # Reportes
└── Utils/                       # Utilidades
    ├── Constants.swift          # Constantes de la app
    ├── DateExtensions.swift     # Extensiones de Date
    └── CurrencyFormatter.swift  # Formateo de moneda
```

##  Tecnologías Utilizadas

- **SwiftUI**: Framework moderno para la interfaz de usuario
- **Combine**: Programación reactiva y manejo de estado
- **Foundation**: Funcionalidades básicas de iOS
- **Charts**: Gráficas nativas de iOS 16+

##  Uso de la Aplicación

###  Dashboard
- Vista general del estado financiero
- Resumen de ingresos, gastos y balance del mes
- Períodos activos y recordatorios

###  Ingresos
- Agregar nuevos ingresos con monto bruto y neto
- Ver cálculo automático de deducciones
- Historial de ingresos por tipo y fecha

###  Gastos
- Categorización automática de gastos
- Captura rápida por categoría
- Seguimiento de gastos recurrentes

###  Deducciones
- Cálculo automático basado en ingresos
- Desglose detallado de ISR e IMSS
- Gestión manual de deducciones adicionales

###  Reportes
- Selección de períodos (semanal, quincenal, mensual)
- Gráficas comparativas
- Análisis de tendencias
- Exportación de datos

##  Personalización

### Categorías de Gastos
Las categorías están definidas en `ExpenseCategory.swift` y se pueden modificar fácilmente:

```swift
enum ExpenseCategory: String, CaseIterable {
    case rent = "Alquiler/Hipoteca"
    case food = "Alimentación"
    // Agregar nuevas categorías aquí
}
```

### Cálculos Fiscales
Los parámetros fiscales se pueden ajustar en `TaxCalculation.swift`:

```swift
struct TaxCalculation {
    var lowerLimit: Double = 15487.72 // Límite inferior 2024
    var marginalPercentage: Double = 21.36 // Porcentaje marginal
    // Modificar según cambios en la ley fiscal
}
