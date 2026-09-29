namespace Cartera.Api.Entities;

public class ClienteContacto
{
    public int ContactoId { get; set; }
    public int ClienteId { get; set; }

    /// <summary>TELEFONO o EMAIL.</summary>
    public string Tipo { get; set; } = "";
    public string Valor { get; set; } = "";
    public bool EsPrincipal { get; set; }

    public Cliente Cliente { get; set; } = null!;
}
