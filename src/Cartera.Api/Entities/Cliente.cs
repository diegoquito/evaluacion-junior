namespace Cartera.Api.Entities;

public class Cliente
{
    public int ClienteId { get; set; }
    public string Identificacion { get; set; } = "";
    public string Nombres { get; set; } = "";

    public List<Contrato> Contratos { get; set; } = new();
    public List<ClienteContacto> Contactos { get; set; } = new();
}
