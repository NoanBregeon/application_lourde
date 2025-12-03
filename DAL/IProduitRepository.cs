using application_lourde.Models;

namespace application_lourde.DAL;

public interface IProduitRepository
{
    Task<IEnumerable<Produit>> GetAllAsync();
    Task<Produit?> GetByIdAsync(int id);
    Task<IEnumerable<Produit>> SearchAsync(string searchTerm);
    Task<IEnumerable<Produit>> GetStockFaibleAsync();
    Task<int> AddAsync(Produit produit);
    Task<bool> UpdateAsync(Produit produit);
    Task<bool> UpdateStockAsync(int id, int nouveauStock);
    Task<bool> DeleteAsync(int id);
}
