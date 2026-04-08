# 📋 Guía Completa de Macros VBA — Formato Cuadre de Caja

---

## 1. ¿Qué es una Macro en Excel?

Una **macro** es un conjunto de instrucciones escritas en lenguaje **VBA (Visual Basic for Applications)** que le indican a Excel que ejecute una serie de acciones de forma automática. En lugar de hacer clic, copiar, pegar o guardar manualmente paso a paso, la macro hace todo eso sola con un solo clic (o al presionar un botón).

Piénselo como una "grabación" de acciones que Excel repite exactamente cada vez que usted lo necesite.

**Ejemplos de lo que puede hacer una macro:**
- Guardar un archivo en formato PDF automáticamente.
- Copiar datos de una hoja a otra.
- Limpiar celdas después de guardar.
- Mostrar u ocultar hojas según una contraseña.
- Mostrar mensajes de alerta al usuario.

---

## 2. ¿Para Qué Sirven las Macros de Este Archivo?

El archivo `FORMATO_CUADRE_DE_CAJA.xlsm` contiene **tres macros** que trabajan juntas para automatizar el proceso de cuadre de caja de un negocio:

| Macro | Función |
|---|---|
| `EnviarArchivo` | Guarda el cuadre como PDF, registra los datos en una hoja oculta y limpia el formulario |
| `VerRegistro` | Permite ver la hoja de registros históricos con contraseña |
| `OcultarRegistro` | Vuelve a ocultar la hoja de registros con contraseña |

---

## 3. Cómo Habilitar la Pestaña "Desarrollador" (Programador) en Excel

Para poder ver, crear o editar macros, primero debe activar la pestaña **Desarrollador**.

### En Excel para Windows:
1. Abra Excel y vaya a **Archivo** → **Opciones**.
2. Haga clic en **Personalizar cinta de opciones** (panel izquierdo).
3. En la lista de la derecha, marque la casilla **Desarrollador**.
4. Haga clic en **Aceptar**.
5. Ahora verá la pestaña **Desarrollador** en la barra de menús superior.

### En Excel para Mac:
1. Vaya a **Excel** (menú superior) → **Preferencias**.
2. Haga clic en **Cinta y barra de herramientas**.
3. En la columna derecha, marque **Desarrollador**.
4. Cierre la ventana.

> ⚠️ **Importante:** Los archivos con macros deben guardarse con la extensión `.xlsm` (no `.xlsx`), de lo contrario las macros se eliminan al guardar.

---

## 4. Cómo Crear una Macro desde Cero

### Método 1: Usando el Editor VBA (recomendado para macros personalizadas)

1. Vaya a la pestaña **Desarrollador** → haga clic en **Visual Basic** (o presione `Alt + F11`).
2. En el panel izquierdo verá el **Explorador de proyectos** con su archivo.
3. Haga clic derecho sobre **Módulos** → **Insertar** → **Módulo**.
4. Se abrirá una hoja en blanco. Escriba su macro así:

```vba
Sub MiPrimeraMacro()
    MsgBox "¡Hola! Esta es mi primera macro."
End Sub
```

5. Presione `F5` o el botón ▶ para ejecutarla.
6. Cierre el editor y guarde el archivo como `.xlsm`.

### Método 2: Grabar Macro (para acciones simples)

1. Vaya a **Desarrollador** → **Grabar macro**.
2. Asígnele un nombre y haga clic en **Aceptar**.
3. Realice las acciones en Excel que quiere automatizar.
4. Cuando termine, haga clic en **Detener grabación**.
5. Excel habrá escrito el código VBA por usted automáticamente.

---

## 5. Cómo Asignar una Macro a un Botón

Para que el usuario ejecute la macro con un clic:

1. Vaya a **Desarrollador** → **Insertar** → **Botón (control de formulario)**.
2. Dibuje el botón en la hoja con el mouse.
3. Aparecerá una ventana: seleccione la macro que desea asignar (por ejemplo, `EnviarArchivo`).
4. Haga clic en **Aceptar**.
5. El botón ya ejecutará la macro al hacer clic.

---

## 6. Objetivo de las Macros en Este Archivo

El objetivo principal es **automatizar el cierre diario de caja** en un negocio, evitando errores manuales y garantizando que:

- ✅ Cada cuadre quede **guardado como PDF** con fecha y hora en el nombre del archivo.
- ✅ Los datos del cuadre queden **registrados automáticamente** en un historial interno (hoja `REGISTRO_CUADRES`).
- ✅ El formulario quede **limpio y listo** para el siguiente cuadre sin borrar fórmulas.
- ✅ El historial esté **protegido con contraseña** y oculto para evitar modificaciones accidentales.

---

## 7. Desglose Completo del Código VBA

---

### 🔷 MACRO 1: `EnviarArchivo`

Esta es la macro principal. Se ejecuta cuando el cajero termina de llenar el formulario y hace clic en el botón de envío.

```vba
Sub EnviarArchivo()
```
> Declara el inicio de la macro con el nombre `EnviarArchivo`. Todo lo que esté entre `Sub` y `End Sub` se ejecutará cuando se llame esta macro.

---

#### 📌 Declaración de Variables

```vba
    Dim ws As Worksheet
    Dim wsRegistro As Worksheet
    Dim rutaPDF As String
    Dim ultimaFila As Long
```

| Variable | Tipo | ¿Para qué se usa? |
|---|---|---|
| `ws` | `Worksheet` | Referencia a la hoja `FORMATO_CUADRE_DE_CAJA` (el formulario visible) |
| `wsRegistro` | `Worksheet` | Referencia a la hoja `REGISTRO_CUADRES` (el historial oculto) |
| `rutaPDF` | `String` (texto) | Guarda la ruta completa donde se guardará el archivo PDF |
| `ultimaFila` | `Long` (número entero largo) | Guarda el número de la primera fila vacía en el registro para no sobrescribir datos anteriores |

> **¿Por qué `Long` y no `Integer`?** Porque `Long` soporta números hasta 2 billones, mientras que `Integer` solo llega a 32,767. Si el registro tiene más de 32,767 filas algún día, `Integer` fallaría. `Long` es la práctica recomendada para conteo de filas.

---

#### 📌 Asignación de Hojas

```vba
    Set ws = ThisWorkbook.Sheets("FORMATO_CUADRE_DE_CAJA")
    Set wsRegistro = ThisWorkbook.Sheets("REGISTRO_CUADRES")
```

> `ThisWorkbook` hace referencia al archivo Excel donde está la macro (este mismo archivo). `.Sheets("nombre")` selecciona una hoja por su nombre. `Set` se usa porque `ws` y `wsRegistro` son **objetos** (no valores simples), y en VBA los objetos se asignan con `Set`.

---

#### 📌 PASO A — Guardar el PDF

```vba
    rutaPDF = ThisWorkbook.Path & "\" & "CuadreCaja_" & _
              Format(Now, "YYYYMMDD_HHMMSS") & ".pdf"
```

> - `ThisWorkbook.Path` → obtiene la carpeta donde está guardado el archivo Excel (por ejemplo: `C:\Usuarios\Maria\Documentos`).
> - `& "\"` → agrega una barra diagonal inversa como separador de carpetas.
> - `"CuadreCaja_"` → prefijo fijo del nombre del archivo.
> - `Format(Now, "YYYYMMDD_HHMMSS")` → `Now` obtiene la fecha y hora actual; `Format(...)` la convierte al texto `20250415_143022`, garantizando que cada PDF tenga un nombre único.
> - `& ".pdf"` → añade la extensión del archivo.
> - El `_` al final de la línea es el **carácter de continuación de línea** en VBA (la instrucción continúa en la siguiente línea).

**Resultado:** El PDF se llamará, por ejemplo: `CuadreCaja_20250415_143022.pdf`

```vba
    ws.PageSetup.PrintArea = "$A$1:$C$36"
```

> Define el **área de impresión** de la hoja: solo se exportará el rango de la celda A1 hasta C36, excluyendo los botones de la macro que están fuera de ese rango.

```vba
    ws.ExportAsFixedFormat Type:=xlTypePDF, _
        Filename:=rutaPDF, _
        Quality:=xlQualityStandard, _
        IncludeDocProperties:=True, _
        IgnorePrintAreas:=False, _
        From:=1, _
        To:=1, _
        OpenAfterPublish:=False
```

> Este comando exporta la hoja como PDF con los siguientes parámetros:

| Parámetro | Valor | Significado |
|---|---|---|
| `Type` | `xlTypePDF` | Formato de salida: PDF |
| `Filename` | `rutaPDF` | Ruta y nombre del archivo (calculada arriba) |
| `Quality` | `xlQualityStandard` | Calidad estándar (no máxima, para un tamaño de archivo razonable) |
| `IncludeDocProperties` | `True` | Incluye propiedades del documento en el PDF |
| `IgnorePrintAreas` | `False` | Respeta el área de impresión definida |
| `From` / `To` | `1` / `1` | Solo exporta la página 1 |
| `OpenAfterPublish` | `False` | No abre el PDF automáticamente al terminar |

```vba
    ws.PageSetup.PrintArea = ""
```

> Limpia el área de impresión después de exportar, dejando la hoja en su estado normal.

---

#### 📌 PASO B — Guardar Datos en el Registro

```vba
    wsRegistro.Visible = xlSheetVisible
    ultimaFila = wsRegistro.Cells(Rows.Count, 1).End(xlUp).Row + 1
```

> - `xlSheetVisible` → hace visible la hoja de registro (estaba oculta con `xlSheetVeryHidden`).
> - `Rows.Count` → número total de filas en Excel (1,048,576 en versiones modernas).
> - `.Cells(Rows.Count, 1)` → va a la última celda posible de la columna A.
> - `.End(xlUp)` → sube desde esa celda hasta encontrar la **última celda con datos** (equivale a presionar `Ctrl + ↑`).
> - `.Row` → obtiene el número de esa fila.
> - `+ 1` → se mueve a la fila siguiente (primera fila vacía disponible).

> **¿Por qué este enfoque?** Garantiza que los nuevos datos siempre se escriban en la siguiente fila libre, sin importar cuántos cuadres se hayan guardado antes.

```vba
    wsRegistro.Cells(ultimaFila, 1).Value = ws.Range("C6").Value   ' FECHA
    wsRegistro.Cells(ultimaFila, 2).Value = ws.Range("C10").Value  ' HORA
    wsRegistro.Cells(ultimaFila, 3).Value = ws.Range("C8").Value   ' ...
    ' ... (continúa para cada campo del formulario)
```

> Cada línea copia el valor de una celda del formulario a la columna correspondiente del registro:
> - `wsRegistro.Cells(ultimaFila, N)` → fila nueva, columna N del registro.
> - `.Value = ws.Range("CX").Value` → copia el **valor visible** (no la fórmula) de la celda CX del formulario.

---

#### 📌 Guardado de Observaciones (bucle)

```vba
    Dim obsTexto As String
    obsTexto = ""
    Dim r As Integer
    For r = 28 To 32
        Dim cellVal As String
        cellVal = Trim(CStr(ws.Cells(r, 2).Value))
        If cellVal <> "" Then
            obsTexto = obsTexto & cellVal & " | "
        End If
        cellVal = Trim(CStr(ws.Cells(r, 3).Value))
        If cellVal <> "" Then
            obsTexto = obsTexto & cellVal & " | "
        End If
    Next r
    wsRegistro.Cells(ultimaFila, 22).Value = Trim(obsTexto)
```

> Las observaciones del formulario ocupan múltiples filas (28 a 32) y dos columnas (B y C). Este bloque:
> - Recorre cada fila del 28 al 32 con el bucle `For r = 28 To 32 ... Next r`.
> - `CStr(...)` convierte el valor de la celda a texto.
> - `Trim(...)` elimina espacios en blanco al inicio y al final.
> - Si la celda no está vacía (`<> ""`), agrega su contenido a `obsTexto` separado por ` | `.
> - Al final guarda todo el texto concatenado en una sola celda del registro (columna 22).

> **¿Por qué concatenar en una sola celda?** Porque el registro tiene una estructura de una fila por cuadre. Las observaciones son texto libre y es más práctico guardarlas juntas.

```vba
    wsRegistro.Visible = xlSheetVeryHidden
```

> Vuelve a **ocultar profundamente** la hoja de registro. `xlSheetVeryHidden` es diferente a `xlSheetHidden`: con `xlSheetVeryHidden` el usuario no puede mostrar la hoja desde el menú de Excel (clic derecho → Mostrar hoja). Solo se puede mostrar desde código VBA.

---

#### 📌 PASO C — Mensaje de Confirmación

```vba
    MsgBox "Realizado exitosamente", vbInformation, "Cuadre de Caja"
```

> Muestra un cuadro de diálogo con:
> - Texto: `"Realizado exitosamente"`
> - Ícono: `vbInformation` (ícono de información ℹ️)
> - Título de la ventana: `"Cuadre de Caja"`

---

#### 📌 PASO D — Limpiar el Formulario

```vba
    ws.Range("C6").ClearContents    ' FECHA
    ws.Range("C10").ClearContents   ' HORA
    ws.Range("B13").ClearContents   ' CANT 100K
    ' ... (continúa para cada campo editable)
```

> `ClearContents` borra solo el **contenido** de la celda (valores escritos por el usuario), pero **NO borra el formato ni las fórmulas**. Esto es importante porque la celda C25 (`TOTAL CUADRE`) tiene una fórmula y **no se borra** intencionalmente.

```vba
    For fr = 28 To 32
        On Error Resume Next
        ws.Cells(fr, 2).MergeArea.ClearContents
        ws.Cells(fr, 3).MergeArea.ClearContents
        On Error GoTo 0
    Next fr
```

> Las filas de observaciones tienen celdas combinadas (merged). `.MergeArea` hace referencia a toda la celda combinada (no solo a la celda individual). `On Error Resume Next` evita que el código se detenga si alguna celda no está combinada; `On Error GoTo 0` restaura el manejo de errores normal.

---

### 🔷 MACRO 2: `VerRegistro`

```vba
Sub VerRegistro()
    Dim clave As String
    clave = InputBox("Ingrese la contraseña para ver el registro:", "Acceso restringido")
    
    If clave = "2324" Then
        ThisWorkbook.Sheets("REGISTRO_CUADRES").Visible = xlSheetVisible
        ThisWorkbook.Sheets("REGISTRO_CUADRES").Activate
        MsgBox "Acceso concedido. Recuerde ocultar la hoja al terminar.", vbInformation
    Else
        MsgBox "Contraseña incorrecta.", vbCritical
    End If
End Sub
```

> - `InputBox(...)` muestra una ventana donde el usuario escribe texto y lo guarda en `clave`.
> - `If clave = "2324"` → si la contraseña es correcta, muestra y activa la hoja del registro.
> - `.Activate` → navega automáticamente a esa hoja (la trae al frente).
> - `Else` → si la contraseña es incorrecta, muestra un mensaje de error con ícono `vbCritical` (❌).

> ⚠️ **Nota de seguridad:** La contraseña `"2324"` está en texto plano dentro del código. Cualquier persona con acceso al editor VBA puede verla. Para mayor seguridad, considere proteger el proyecto VBA con contraseña desde el editor: *Herramientas → Propiedades de VBAProject → Protección*.

---

### 🔷 MACRO 3: `OcultarRegistro`

```vba
Sub OcultarRegistro()
    Dim clave As String
    clave = InputBox("Ingrese la contraseña para ocultar el registro:", "Confirmar")
    
    If clave = "2324" Then
        ThisWorkbook.Sheets("REGISTRO_CUADRES").Visible = xlSheetVeryHidden
        MsgBox "Hoja ocultada correctamente.", vbInformation
    Else
        MsgBox "Contraseña incorrecta.", vbCritical
    End If
End Sub
```

> Funciona igual que `VerRegistro` pero en sentido inverso: oculta la hoja con `xlSheetVeryHidden` en lugar de mostrarla. Esto asegura que el encargado pueda dejar el archivo en su estado seguro después de revisar el registro.

---

## 8. Flujo Completo de Uso

```
Usuario llena el formulario (FORMATO_CUADRE_DE_CAJA)
            ↓
    Hace clic en el botón "Enviar"
            ↓
    Se ejecuta EnviarArchivo()
            ↓
    ┌─────────────────────────────┐
    │ A) Guarda PDF con timestamp │
    │ B) Copia datos al registro  │
    │ C) Muestra mensaje de éxito │
    │ D) Limpia el formulario     │
    └─────────────────────────────┘
            ↓
    Formulario listo para el próximo cuadre

Para ver historial:
    Clic en "Ver Registro" → Contraseña → REGISTRO_CUADRES visible

Para ocultar historial:
    Clic en "Ocultar Registro" → Contraseña → REGISTRO_CUADRES oculto
```

---

## 9. Resumen de Conceptos VBA Usados

| Elemento | ¿Qué hace? |
|---|---|
| `Sub ... End Sub` | Define el inicio y fin de una macro |
| `Dim x As Tipo` | Declara una variable con su tipo de dato |
| `Set x = objeto` | Asigna un objeto (hoja, rango) a una variable |
| `ThisWorkbook` | Referencia al archivo Excel actual |
| `.Sheets("nombre")` | Selecciona una hoja por nombre |
| `Range("C6").Value` | Lee o escribe el valor de una celda |
| `Cells(fila, col).Value` | Lee o escribe por número de fila y columna |
| `ClearContents` | Borra el contenido sin borrar formato ni fórmulas |
| `ExportAsFixedFormat` | Exporta una hoja a PDF u otro formato fijo |
| `MsgBox` | Muestra un mensaje emergente al usuario |
| `InputBox` | Muestra una caja para que el usuario escriba texto |
| `For ... Next` | Bucle que repite acciones un número definido de veces |
| `If ... Else ... End If` | Condición: ejecuta código según si algo es verdadero o falso |
| `Trim()` | Elimina espacios en blanco al inicio y al final de un texto |
| `CStr()` | Convierte un valor a tipo texto (String) |
| `Format(fecha, patrón)` | Formatea una fecha/hora como texto con un patrón definido |
| `xlSheetVeryHidden` | Oculta una hoja de forma que no pueda mostrarse desde el menú |
| `On Error Resume Next` | Ignora errores en la siguiente línea de código |
| `On Error GoTo 0` | Restaura el manejo de errores normal |

---

*Documento generado automáticamente a partir del análisis del archivo `FORMATO_CUADRE_DE_CAJA.xlsm`*
