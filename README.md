# 🚀 GUÍA DE INSTALACIÓN - GYM MEJORAS DOCKER

## Requisitos Previos

- **Docker Desktop** instalado (Windows/Mac/Linux)
- Al menos 2GB de RAM disponible

---

## 📦 Archivos Incluidos

- `docker-compose.yml` - Configuración de servicios
- `Dockerfile` - Imagen de PHP + Apache
- `.env` - Variables de entorno
- `db/init.sql` - Estructura de base de datos

---

## 🔧 Instalación

### 1. Estructura de carpetas

El proyecto debe tener esta estructura:

```
gym_mejoras_microservicio/
├── docker-compose.yml
├── Dockerfile
├── .env
├── db/
│   └── init.sql
└── app/
    └── [copiar todos los archivos de gym_mejoras]
```

### 2. Copiar archivos de la aplicación

Copia todo el contenido de `gym_mejoras` (excepto config/Database.php) a la carpeta `app/`.

**NOTA:** El archivo `config/Database.php` ya está configurado para Docker con las credenciales del contenedor.

### 3. Configurar Database.php

El archivo ya viene configurado para Docker:
- Host: `db` (nombre del servicio MySQL)
- Usuario: `gymuser`
- Contraseña: `gympass123`
- Base de datos: `gym_ma_db`

---

## ▶️ Ejecutar el Sistema

### Windows (PowerShell)

```powershell
cd C:\xampp\htdocs\proyecto\gym_mejoras_microservicio
docker-compose up -d
```

### Linux/Mac (Terminal)

```bash
cd /ruta/a/gym_mejoras_microservicio
docker-compose up -d
```

---

## 🌐 Acceder al Sistema

| Servicio | URL |
|----------|-----|
| **GYM** | http://localhost:8080 |
| **phpMyAdmin** | http://localhost:8081 |

### Credenciales phpMyAdmin

- **Usuario:** root
- **Contraseña:** root

### Credenciales GYM

- **Usuario:** admin
- **Contraseña:** admin123

---

## 📋 Comandos Útiles

```bash
# Iniciar servicios
docker-compose up -d

# Ver logs
docker-compose logs -f

# Detener servicios
docker-compose down

# Ver estado
docker-compose ps

# Reiniciar un servicio
docker-compose restart web
```

---

## 🐛 Solución de Problemas

### Error: "Container already running"

```bash
docker-compose down
docker-compose up -d
```

### Error de permisos (Linux)

```bash
sudo chown -R $USER:$USER .
```

### Ver logs de errores

```bash
docker-compose logs web
docker-compose logs db
```

---

## 📝 Notas

- El sistema se ejecuta en el puerto 8080 (para evitar conflictos con XAMPP)
- Los datos de MySQL se guardan en un volumen Docker
- La base de datos se inicializa automáticamente con las tablas

---

## ✅ Verificar que todo funcione

1. Abrir http://localhost:8080
2. Login con: admin / admin123
3. ¡Listo!

---

**Versión:** 1.0
**Fecha:** 2026-03-25