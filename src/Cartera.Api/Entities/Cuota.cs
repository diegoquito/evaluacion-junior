namespace Cartera.Api.Entities;

public class Cuota
{
    public int CuotaId { get; set; }
    public int ContratoId { get; set; }
    public int NumeroCuota { get; set; }
    public DateOnly FechaVencimiento { get; set; }
    public decimal Monto { get; set; }
    public decimal SaldoPendiente { get; set; }
    public bool Pagada { get; set; }

    public Contrato Contrato { get; set; } = null!;
}
