using Cartera.Api.Entities;
using Microsoft.EntityFrameworkCore;

namespace Cartera.Api.Data;

public class CarteraDbContext(DbContextOptions<CarteraDbContext> options) : DbContext(options)
{
    public DbSet<Cliente> Clientes => Set<Cliente>();
    public DbSet<ClienteContacto> ClienteContactos => Set<ClienteContacto>();
    public DbSet<Contrato> Contratos => Set<Contrato>();
    public DbSet<Cuota> Cuotas => Set<Cuota>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Cliente>(e =>
        {
            e.ToTable("Cliente");
            e.HasKey(c => c.ClienteId);
            e.Property(c => c.Identificacion).HasMaxLength(13).IsUnicode(false);
            e.Property(c => c.Nombres).HasMaxLength(150);

            e.HasMany(c => c.Contratos)
                .WithOne(c => c.Cliente)
                .HasForeignKey(c => c.ClienteId);

            e.HasMany(c => c.Contactos)
                .WithOne(c => c.Cliente)
                .HasForeignKey(c => c.ClienteId);
        });

        modelBuilder.Entity<ClienteContacto>(e =>
        {
            e.ToTable("ClienteContacto");
            e.HasKey(c => c.ContactoId);
            e.Property(c => c.Tipo).HasMaxLength(10).IsUnicode(false);
            e.Property(c => c.Valor).HasMaxLength(100);
        });

        modelBuilder.Entity<Contrato>(e =>
        {
            e.ToTable("Contrato");
            e.HasKey(c => c.ContratoId);
            e.Property(c => c.NumeroContrato).HasMaxLength(20).IsUnicode(false);
            e.Property(c => c.Producto).HasMaxLength(100);
            e.Property(c => c.Estado).HasMaxLength(10).IsUnicode(false);

            e.HasMany(c => c.Cuotas)
                .WithOne(c => c.Contrato)
                .HasForeignKey(c => c.ContratoId);
        });

        modelBuilder.Entity<Cuota>(e =>
        {
            e.ToTable("Cuota");
            e.HasKey(c => c.CuotaId);
            e.Property(c => c.Monto).HasPrecision(12, 2);
            e.Property(c => c.SaldoPendiente).HasPrecision(12, 2);
        });
    }
}
