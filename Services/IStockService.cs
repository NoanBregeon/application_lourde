using application_lourde.Models;

namespace application_lourde.Services;

public interface IStockService
{
    Task<IEnumerable<Produit>> GetAllProduitsAsync();
    Task<IEnumerable<Produit>> SearchProduitsAsync(string searchTerm);
    Task<IEnumerable<Produit>> GetProduitsStockFaibleAsync();
    Task<bool> AjouterProduitAsync(Produit produit);
    Task<bool> ModifierProduitAsync(Produit produit);
    Task<bool> ModifierStockAsync(int produitId, int nouveauStock);
    Task<bool> SupprimerProduitAsync(int produitId);
}
