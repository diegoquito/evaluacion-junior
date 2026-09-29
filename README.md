# Evaluación técnica: Developer Junior

Ambiente para la entrevista técnica. Prepáralo **al menos un día antes** y, si algo falla, avísanos antes de la entrevista.

## Requisitos

- .NET 8 SDK (`dotnet --version` debe mostrar 8.0 o superior)
- Node.js 20 LTS y Angular CLI 17 o superior (`npm install -g @angular/cli`)
- Docker Desktop
- Un editor: Visual Studio 2022, VS Code o Rider
- Un cliente SQL: SQL Server Management Studio, Azure Data Studio o la extensión de SQL Server para VS Code
- Git y tu asistente de IA con la sesión iniciada

## Levantar el ambiente

```bash
# 1. Base de datos: crea la base Cartera y carga los datos de prueba
docker compose up -d
docker compose logs -f db-init   # espera el mensaje "Base de datos Cartera lista." y sal con Ctrl+C

# 2. API (en una terminal)
dotnet run --project src/Cartera.Api

# 3. Frontend (en otra terminal)
cd src/cartera-web
npm install
ng serve
```

## Verificar

- http://localhost:5000/swagger muestra la documentación de la API.
- http://localhost:4200 muestra **«Cartera: ambiente listo»** y la cantidad de clientes cargados.

## El día de la entrevista

Reinicia la base para que las fechas de prueba se calculen sobre ese día:

```bash
docker compose down && docker compose up -d
```

## Datos de conexión a SQL Server

| Dato        | Valor              |
|-------------|--------------------|
| Servidor    | `localhost,1433`   |
| Usuario     | `sa`               |
| Contraseña  | `Evaluacion.2026!` |
| Base        | `Cartera`          |

Son credenciales de un contenedor local, solo para esta evaluación. En tu cliente SQL activa la opción de confiar en el certificado del servidor.

## Estructura

```
evaluacion-junior/
├── Cartera.sln
├── docker-compose.yml
├── db/
│   ├── 01-esquema.sql
│   └── 02-datos.sql
└── src/
    ├── Cartera.Api/              ASP.NET Core 8 + EF Core 8
    │   ├── Controllers/
    │   ├── Data/CarteraDbContext.cs
    │   ├── Entities/             Cliente, ClienteContacto, Contrato, Cuota
    │   └── Program.cs
    └── cartera-web/              Angular 17
        └── src/app/contratos/    ContratosService y ContratosComponent
```

La API registra en consola el SQL que genera EF Core, para que puedas ver las consultas que se ejecutan.

## Problemas frecuentes

**El puerto 5000 está ocupado en macOS.** El Receptor de AirPlay usa ese puerto. Desactívalo en Ajustes del Sistema → General → AirDrop y Handoff → Receptor de AirPlay.

**El puerto 1433 está ocupado.** Tienes otra instancia de SQL Server en ejecución. Detenla mientras dure la evaluación.

**Mac con Apple Silicon (M1 o posterior).** La imagen de SQL Server es para x86. En Docker Desktop, activa Settings → General → «Use Rosetta for x86_64/amd64 emulation on Apple Silicon».

**La página de Angular dice «La API no responde».** Revisa que la API esté en ejecución y que `docker compose logs db-init` muestre «Base de datos Cartera lista.».
