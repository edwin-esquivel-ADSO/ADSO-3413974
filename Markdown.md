# Manual Básico de Git y Markdown

## 1. ¿Qué es un Manual?

Un **manual** es un documento que contiene información organizada y detallada sobre el funcionamiento, uso o desarrollo de un sistema, herramienta o proceso.

En el desarrollo de software, los manuales sirven para:

- Explicar cómo funciona un proyecto
- Mostrar cómo instalar o ejecutar un sistema
- Documentar procedimientos técnicos
- Guiar a otros desarrolladores o usuarios

Los manuales permiten **facilitar el aprendizaje, la colaboración y el mantenimiento del software**.

---

# 2. ¿Qué es Markdown (.md)?

**Markdown** es un lenguaje de marcado ligero que permite crear documentos con formato utilizando texto simple.

Los archivos Markdown utilizan la extensión:

```
.md
```

Se utilizan principalmente en:

- Documentación de software
- Archivos README
- Manuales técnicos
- Documentación en GitHub

### Ejemplo de formato en Markdown

```
# Título
## Subtítulo
**Negrita**
*Itálica*

- Lista
- Lista
- Lista
```

Markdown permite crear documentos claros y fáciles de leer.

---

# 3. ¿Qué es Git?

**Git** es un sistema de control de versiones distribuido que permite gestionar los cambios realizados en un proyecto de software.

Git permite:

- Guardar versiones del proyecto
- Registrar cambios realizados
- Trabajar en equipo
- Recuperar versiones anteriores

Git es ampliamente utilizado en plataformas como **GitHub**, **GitLab** y **Bitbucket**.

---

# 4. Clonar un Repositorio

Clonar significa **descargar un repositorio remoto a tu computador**.

Comando:

```bash
git clone URL_DEL_REPOSITORIO
```

Ejemplo:

```bash
git clone https://github.com/usuario/proyecto.git
```

Esto descargará el proyecto completo en tu equipo.

---

# 5. Verificar el Estado del Proyecto

Para ver qué archivos han cambiado se utiliza:

```bash
git status
```

Este comando muestra:

- Archivos modificados
- Archivos nuevos
- Archivos listos para commit

---

# 6. Agregar Archivos al Área de Preparación (Staging)

Antes de guardar cambios se deben agregar los archivos.

Agregar todos los archivos:

```bash
git add .
```

Agregar un archivo específico:

```bash
git add nombre_archivo
```

---

# 7. Crear un Commit

Un **commit** guarda los cambios realizados en el proyecto.

Comando:

```bash
git commit -m "Descripción del cambio"
```

Ejemplo:

```bash
git commit -m "Se agrega documentación del proyecto"
```

Cada commit queda guardado en el historial del proyecto.

---

# 8. Subir Cambios al Repositorio (Push)

El comando **push** permite enviar los cambios desde el repositorio local al repositorio remoto.

```bash
git push
```

Si es la primera vez:

```bash
git push origin main
```

Esto actualizará el repositorio en GitHub.

---

# 9. Descargar Cambios del Repositorio (Pull)

El comando **pull** permite actualizar el repositorio local con los cambios del repositorio remoto.

```bash
git pull
```

Esto es importante cuando se trabaja en equipo.

---

# 10. Crear una Rama (Branch)

Una **rama (branch)** permite trabajar en nuevas funcionalidades sin afectar la versión principal del proyecto.

Crear una rama:

```bash
git branch nombre_rama
```

Ejemplo:

```bash
git branch nueva_funcionalidad
```

---

# 11. Cambiar de Rama

Para cambiar entre ramas se usa:

```bash
git checkout nombre_rama
```

Ejemplo:

```bash
git checkout nueva_funcionalidad
```

---

# 12. Fusionar Ramas (Merge)

El **merge** permite unir los cambios de una rama con otra.

Primero cambiar a la rama principal:

```bash
git checkout main
```

Luego fusionar:

```bash
git merge nombre_rama
```

Ejemplo:

```bash
git merge nueva_funcionalidad
```

Esto integrará los cambios en la rama principal.

---

# 13. Flujo de Trabajo Básico en Git

El flujo más común al trabajar con Git es:

1. Clonar el repositorio

```
git clone
```

2. Crear o modificar archivos

3. Revisar cambios

```
git status
```

4. Agregar archivos

```
git add .
```

5. Crear commit

```
git commit -m "mensaje"
```

6. Subir cambios

```
git push
```

7. Actualizar repositorio

```
git pull
```

---

# 14. Buenas Prácticas

- Escribir mensajes de commit claros
- Hacer commits pequeños y frecuentes
- Actualizar el repositorio antes de trabajar (`git pull`)
- Usar ramas para nuevas funcionalidades
- Mantener la documentación actualizada

---

# 15. Conclusión

El uso de **Git** permite llevar un control organizado de los cambios en un proyecto de software, facilitando el trabajo en equipo y el mantenimiento del código.

Por otra parte, **Markdown** permite crear documentación clara y estructurada, lo cual es fundamental para explicar el funcionamiento de los proyectos y su uso.