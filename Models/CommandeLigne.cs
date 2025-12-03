namespace application_lourde.Models;

public class CommandeLigne
{
    public int Id { get; set; }
    public int CommandeId { get; set; }
    public int ProduitId { get; set; }
    public int QuantiteDemandee { get; set; }
    public int QuantitePreparee { get; set; }
    public decimal PrixUnitaireHT { get; set; }
    public string StatutLigne { get; set; } = "A_VALIDER";
    public string? Note { get; set; }
    
    // Propriétés de navigation/affichage
    public string ProduitLibelle { get; set; } = string.Empty;
    public int StockDisponible { get; set; }
    
    // Pour compatibilité avec l'UI existante
    public bool EnRupture 
    { 
        get => StatutLigne == "RUPTURE";
        set => StatutLigne = value ? "RUPTURE" : "VALIDEE";
    }
}
