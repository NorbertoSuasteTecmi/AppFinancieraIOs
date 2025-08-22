# AppFinancieraIOs - Playground de Xcode

## ¿Qué es este Playground?

Este playground contiene una aplicación iOS completa de gestión financiera personal, diseñada específicamente para freelancers y profesionales independientes. La app incluye cálculo automático de deducciones fiscales mexicanas, gestión de gastos por categorías, y reportes periódicos.

## Cómo usar el Playground

1. **Abrir en Xcode**: Abre el archivo `AppFinancieraIOs.playground` en Xcode
2. **Ejecutar**: Presiona el botón de "Run" (▶️) en Xcode
3. **Vista en vivo**: La app se ejecutará en el panel de vista en vivo del playground

## Características del Playground

### ✅ Funcionalidades Completas
- **Dashboard**: Vista general del estado financiero
- **Gestión de Ingresos**: Agregar y visualizar ingresos
- **Gestión de Gastos**: Categorización y seguimiento de gastos
- **Cálculo de Deducciones**: ISR e IMSS automático
- **Reportes**: Generación de reportes por períodos

### ✅ Interfaz Interactiva
- Navegación por pestañas
- Formularios funcionales
- Listas dinámicas
- Navegación completa

### ✅ Lógica de Negocio
- ViewModels con estado observable
- Cálculos fiscales reales
- Gestión de datos en memoria

## Estructura del Código

### Models
- `Income`: Modelo de ingresos con tipos y recurrencia
- `Expense`: Modelo de gastos con categorías
- `Deduction`: Modelo de deducciones fiscales
- `TaxCalculation`: Lógica de cálculo de impuestos

### ViewModels
- `DashboardViewModel`: Estado del dashboard
- `IncomeViewModel`: Gestión de ingresos
- `ExpensesViewModel`: Gestión de gastos
- `DeductionsViewModel`: Cálculo de deducciones

### Views
- `DashboardView`: Vista principal con balance
- `IncomeView`: Lista y formulario de ingresos
- `ExpensesView`: Lista y formulario de gastos
- `DeductionsView`: Calculadora de deducciones
- `ReportsView`: Generación de reportes

## Ventajas del Playground

1. **Desarrollo Rápido**: No necesitas crear un proyecto completo
2. **Prototipado**: Ideal para probar ideas y funcionalidades
3. **Aprendizaje**: Código completo y funcional para estudiar
4. **Portabilidad**: Fácil de compartir y ejecutar en cualquier Mac

## Requisitos

- Xcode 14.0 o superior
- iOS 16.0+ (para SwiftUI Charts)
- macOS 13.0+ (para ejecutar el playground)

## Notas Importantes

- Los datos se almacenan en memoria (se pierden al cerrar)
- El playground simula una app completa
- Todas las funcionalidades están implementadas y funcionando
- Ideal para demostraciones y prototipos

## Personalización

Puedes modificar fácilmente:
- Categorías de gastos en `ExpenseCategory`
- Parámetros fiscales en `TaxCalculation`
- Colores y estilos en las vistas
- Agregar nuevas funcionalidades

## Siguiente Paso

Una vez que estés satisfecho con el prototipo en el playground, puedes:
1. Crear un proyecto iOS completo
2. Copiar el código del playground
3. Agregar persistencia de datos (Core Data)
4. Implementar notificaciones y widgets
5. Publicar en la App Store

---

**¡Disfruta explorando la app financiera en el playground!**
