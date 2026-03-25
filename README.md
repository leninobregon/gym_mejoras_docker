# 🚀 GUÍA DE INSTALACIÓN - GYM MEJORAS DOCKER

## Requisitos Previos

- **Docker** instalado
- **Docker Compose** instalado
- Al menos 2GB de RAM disponible

---

## 📥 Opción 1: Clonar desde GitHub (Recomendado)

```bash
# 1. Instalar Docker (si no lo tienes)
sudo apt update
sudo apt install docker.io docker-compose

# 2. Iniciar Docker
sudo systemctl start docker
sudo systemctl enable docker

# 3. Clonar el repositorio
git clone https://github.com/leninobregon/gym_mejoras_docker.git gym_docker
cd gym_docker

# 4. Copiar archivos de la aplicación
# Descarga el zip de gym_mejoras desde:
# https://github.com/leninobregon/gymma/archive/refs/heads/master.zip
# Extrae el contenido a la carpeta 'app/' (excepto config/Database.php)

# 5. Ejecutar el sistema
docker-compose up -d
```

---

## 📦 Opción 2: Descargar ZIP desde GitHub

```bash
# 1. Descargar el repositorio como ZIP
wget https://github.com/leninobregon/gym_mejoras_docker/archive/refs/heads/master.zip
unzip master.zip
cd gym_mejoras_docker-master

# 2. Descargar la aplicación (gym_mejoras)
wget https://github.com/leninobregon/gymma/archive/refs/heads/master.zip
unzip master.zip
cp -r gymma-master/* app/

# 3. Ejecutar
docker-compose up -d
```

---

## 🔧 Configuración de la Aplicación

### Estructura de carpetas

```
gym_mejoras_docker/
├── docker-compose.yml
├── Dockerfile
├── .env
├── db/
│   └── init.sql
└── app/
    ├── config/
    │   └── Database.php  ← Ya viene configurado para Docker
    ├── views/
    ├── controllers/
    └── ... (otros archivos de gym_mejoras)
```

### ⚠️ Importante

El archivo `app/config/Database.php` ya está configurado para Docker:
- Host: `db`
- Usuario: `gymuser`
- Contraseña: `gympass123`
- Base de datos: `gym_ma_db`

No lo modifiques.

---

## ▶️ Ejecutar el Sistema

```bash
cd gym_mejoras_docker
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

# Reiniciar
docker-compose restart

# Eliminar todo (incluyendo datos)
docker-compose down -v
```

---

## 🐛 Solución de Problemas

### Docker no está corriendo
```bash
sudo systemctl start docker
sudo systemctl enable docker
```

### Error de permisos
```bash
sudo chown -R $USER:$USER .
```

### Ver logs de errores
```bash
docker-compose logs web
docker-compose logs db
```

---

## ✅ Verificar que todo funcione

1. Abrir http://localhost:8080
2. Login con: admin / admin123
3. ¡Listo!

---

**Versión:** 1.0
**Fecha:** 2026-03-25