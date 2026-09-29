using Cartera.Api.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<CarteraDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("Cartera")));

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddCors(options =>
    options.AddPolicy("Frontend", policy => policy
        .WithOrigins("http://localhost:4200")
        .AllowAnyHeader()
        .AllowAnyMethod()));

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("Frontend");
app.MapControllers();

// Comprueba que la API y la base de datos respondan.
app.MapGet("/api/salud", async (CarteraDbContext db) =>
{
    var clientes = await db.Clientes.CountAsync();
    return Results.Ok(new { estado = "ok", clientes });
})
.WithTags("Salud");

// Puedes agregar tus endpoints aquí (Minimal API) o crear controladores en la carpeta Controllers.

app.Run();
