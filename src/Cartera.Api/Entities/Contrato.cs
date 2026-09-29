namespace Cartera.Api.Entities;

public class Contrato
{
    public int ContratoId { get; set; }
    public int ClienteId { get; set; }
    public string NumeroContrato { get; set; } = "";
    public string Producto { get; set; } = "";

    /// <summary>ACTIVO, CANCELADO o ANULADO. Ver <see cref="EstadosContrato"/>.</summary>
    public string Estado { get; set; } = "";
    public DateOnly FechaFirma { get; set; }

    public Cliente Cliente { get; set; } = null!;
    public List<Cuota> Cuotas { get; set; } = new();
}

public static class EstadosContrato
{
    public const string Activo = "ACTIVO";
    public const string Cancelado = "CANCELADO";
    public const string Anulado = "ANULADO";
}
