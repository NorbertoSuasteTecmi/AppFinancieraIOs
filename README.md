# App Financiera iOS

Una aplicación móvil desarrollada en SwiftUI para la gestión personal de finanzas, diseñada específicamente para el contexto mexicano con cálculos de impuestos y deducciones locales.

## Descripción

App Financiera es una herramienta completa para el control financiero personal que permite a los usuarios gestionar sus ingresos, gastos, deducciones y generar reportes detallados. La aplicación está optimizada para el sistema fiscal mexicano, incluyendo cálculos automáticos de ISR, IMSS y subsidio al empleo.

## Características Principales

### Gestión de Ingresos
- Registro de diferentes tipos de ingresos (empleo, freelance, inversiones, otros)
- Cálculo automático de salario neto considerando deducciones fiscales
- Soporte para ingresos recurrentes (semanal, quincenal, mensual, anual)
- Categorización de ingresos por tipo

### Control de Gastos
- Categorización inteligente de gastos en tres niveles:
  - **Fijos obligatorios**: Alquiler/hipoteca, préstamos, impuestos
  - **Fijos reducibles**: Servicios básicos, alimentación, transporte, educación
  - **Variables**: Ocio, viajes, suscripciones
- Registro de gastos con notas y comprobantes
- Soporte para gastos recurrentes
- Seguimiento de gastos por categoría

### Deducciones Fiscales
- Cálculo automático de ISR (Impuesto Sobre la Renta)
- Deducciones de IMSS
- Cálculo de subsidio al empleo
- Registro de deducciones adicionales

### Reportes y Análisis
- Dashboard con resumen financiero
- Visualización de gastos por categoría
- Reportes de ingresos recientes
- Análisis de períodos financieros activos

## Estructura del Proyecto

```
Appfinancierafuncional/
├── Models/
│   ├── Income.swift              # Modelo de ingresos
│   ├── Expense.swift             # Modelo de gastos
│   ├── ExpenseCategory.swift     # Categorías de gastos
│   ├── Deduction.swift           # Modelo de deducciones
│   ├── TaxCalculation.swift      # Cálculos fiscales
│   └── FinancialPeriod.swift     # Períodos financieros
├── ViewModels/
│   ├── DashboardViewModel.swift  # Lógica del dashboard
│   ├── IncomeViewModel.swift     # Gestión de ingresos
│   ├── ExpensesViewModel.swift   # Gestión de gastos
│   ├── DeductionsViewModel.swift # Gestión de deducciones
│   └── ReportsViewModel.swift    # Lógica de reportes
├── Views/
│   ├── Main/                     # Vistas principales
│   ├── Income/                   # Vistas de ingresos
│   ├── Expenses/                 # Vistas de gastos
│   ├── Deductions/               # Vistas de deducciones
│   └── Reports/                  # Vistas de reportes
└── Utils/
    ├── Constants.swift           # Constantes de la aplicación
    ├── CurrencyFormatter.swift   # Formateo de moneda
    └── DateExtensions.swift      # Extensiones de fecha
```

## Tecnologías Utilizadas

- **SwiftUI**: Framework de interfaz de usuario
- **Core Data**: Persistencia de datos local
- **Combine**: Programación reactiva
- **Foundation**: Funcionalidades base de iOS

## Requisitos del Sistema

- iOS 15.0 o superior
- Xcode 13.0 o superior
- Swift 5.5 o superior

## Instalación

1. Clona el repositorio:
```bash
git clone https://github.com/NorbertoSuasteTecmi/AppFinancieraIOs.git
```

2. Abre el proyecto en Xcode:
```bash
cd AppFinancieraIOs/Appfinancierafuncional
open Appfinancierafuncional.xcodeproj
```

3. Compila y ejecuta la aplicación en el simulador o dispositivo

## Uso de la Aplicación

### Dashboard
La pantalla principal muestra un resumen de tu situación financiera actual, incluyendo:
- Ingresos recientes
- Gastos principales por categoría
- Períodos financieros activos

### Gestión de Ingresos
1. Navega a la pestaña "Ingresos"
2. Toca el botón "+" para agregar un nuevo ingreso
3. Completa la información requerida
4. Selecciona si es un ingreso recurrente

### Control de Gastos
1. Ve a la pestaña "Gastos"
2. Agrega gastos categorizándolos apropiadamente
3. Los gastos se clasifican automáticamente según su tipo
4. Puedes agregar notas y comprobantes

### Deducciones
1. Accede a la pestaña "Deducciones"
2. La aplicación calcula automáticamente ISR e IMSS
3. Puedes agregar deducciones adicionales

### Reportes
1. Ve a la pestaña "Reportes"
2. Visualiza análisis detallados de tus finanzas
3. Exporta información según sea necesario

## Cálculos Fiscales

La aplicación implementa las tablas fiscales mexicanas vigentes para 2024:

- **ISR**: Cálculo basado en tablas del SAT con límite inferior de $15,487.72
- **IMSS**: 2.75% del salario bruto
- **Subsidio al Empleo**: Calculado según las tablas oficiales del SAT

## Contribuciones

Este proyecto es parte de un trabajo académico del 5to semestre de la Universidad Tecmilenio. Las contribuciones están limitadas al equipo de desarrollo.

## Licencia

Este proyecto es de uso académico y no está destinado para distribución comercial.

## Contacto

Para consultas sobre el proyecto, contacta al equipo de desarrollo a través del repositorio de GitHub.

---

**Nota**: Esta aplicación está diseñada específicamente para el contexto fiscal mexicano y utiliza las tablas de impuestos vigentes para 2024.
