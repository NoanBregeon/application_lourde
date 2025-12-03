namespace application_lourde.Models;

public class Produit
{
    public int Id { get; set; }
    public string Reference { get; set; } = string.Empty;
    public string Libelle { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? Image { get; set; }
    public string? Categorie { get; set; }
    public decimal PrixHT { get; set; }
    public decimal TVA { get; set; }
    public int Stock { get; set; }
    public bool Actif { get; set; } = true;
    public DateTime? CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    
    // Propriétés calculées
    public decimal TauxTVA 
    { 
        get => TVA;
        set => TVA = value; // Rendre modifiable pour compatibilité
    }
    public decimal PrixTTC => PrixHT * (1 + TVA / 100);
    public bool StockFaible => Stock < 5;
    
    // Chemin complet de l'image pour l'affichage
    public string? CheminImage
    {
        get
        {
            if (string.IsNullOrEmpty(Image))
                return null;
            
            // Chemin partagé accessible par le site web et WPF
            return $@"C:\inetpub\wwwroot\epreuve_e6\public\storage\produits\{Image}";
        }
    }
    
    // URL de l'image pour le site web
    public string? UrlImage
    {
        get
        {
            if (string.IsNullOrEmpty(Image))
                return null;
            
            return $"/storage/produits/{Image}";
        }
    }
}
