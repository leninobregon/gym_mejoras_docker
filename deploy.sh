#!/bin/bash

echo "🚀 Iniciando GYM Docker..."

# Verificar Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado"
    echo "📦 Instalando Docker..."
    sudo apt update
    sudo apt install docker.io docker-compose
fi

# Iniciar Docker si no está corriendo
if ! docker info &> /dev/null; then
    echo "🔄 Iniciando servicio Docker..."
    sudo systemctl start docker
    sudo systemctl enable docker
fi

# Verificar que estamos en el directorio correcto
if [ ! -f "docker-compose.yml" ]; then
    echo "❌ Error: Ejecuta este script desde la carpeta gym_mejoras_docker"
    exit 1
fi

# Detener contenedores anteriores
echo "🛑 Deteniendo contenedores anteriores..."
docker-compose down 2>/dev/null

# Iniciar servicios
echo "▶️ Iniciando servicios..."
docker-compose up -d --build

# Esperar a que la base de datos esté lista
echo "⏳ Esperando base de datos..."
sleep 10

echo ""
echo "✅ ¡GYM Docker iniciado!"
echo ""
echo "🌐 Accesos:"
echo "   GYM:        http://localhost:8080"
echo "   phpMyAdmin: http://localhost:8081"
echo ""
echo "📋 Credenciales:"
echo "   phpMyAdmin: root / root"
echo "   GYM:        admin / admin123"
echo ""
echo "📝 Comandos útiles:"
echo "   docker-compose logs -f  # Ver logs"
echo "   docker-compose down    # Detener"
echo "   docker-compose restart # Reiniciar"
