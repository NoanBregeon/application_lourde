using application_lourde.DAL;
using application_lourde.Models;

namespace application_lourde.Services;

public class StockService : IStockService
{
    private readonly IProduitRepository _produitRepository;

    public StockService(IProduitRepository produitRepository)
    {
        _produitRepository = produitRepository;
    }

    public async Task<IEnumerable<Produit>> GetAllProduitsAsync()
    {
        try
        {
            return await _produitRepository.GetAllAsync();
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("Erreur lors de la récupération des produits", ex);
        }
    }

    public async Task<IEnumerable<Produit>> SearchProduitsAsync(string searchTerm)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(searchTerm))
                return await GetAllProduitsAsync();

            return await _produitRepository.SearchAsync(searchTerm);
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("Erreur lors de la recherche de produits", ex);
        }
    }

    public async Task<IEnumerable<Produit>> GetProduitsStockFaibleAsync()
    {
        try
        {
            return await _produitRepository.GetStockFaibleAsync();
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("Erreur lors de la récupération des produits en stock faible", ex);
        }
    }

    public async Task<bool> AjouterProduitAsync(Produit produit)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(produit.Libelle))
                throw new ArgumentException("Le libellé est obligatoire");

            if (string.IsNullOrWhiteSpace(produit.Reference))
                throw new ArgumentException("La référence est obligatoire");

            var id = await _produitRepository.AddAsync(produit);
            return id > 0;
        }
        catch (Exception ex) when (ex is not ArgumentException)
        {
            throw new InvalidOperationException("Erreur lors de l'ajout du produit", ex);
        }
    }

    public async Task<bool> ModifierProduitAsync(Produit produit)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(produit.Libelle))
                throw new ArgumentException("Le libellé est obligatoire");

            if (string.IsNullOrWhiteSpace(produit.Reference))
                throw new ArgumentException("La référence est obligatoire");

            return await _produitRepository.UpdateAsync(produit);
        }
        catch (Exception ex) when (ex is not ArgumentException)
        {
            throw new InvalidOperationException("Erreur lors de la modification du produit", ex);
        }
    }

    public async Task<bool> ModifierStockAsync(int produitId, int nouveauStock)
    {
        try
        {
            if (nouveauStock < 0)
                throw new ArgumentException("Le stock ne peut pas être négatif");

            return await _produitRepository.UpdateStockAsync(produitId, nouveauStock);
        }
        catch (Exception ex) when (ex is not ArgumentException)
        {
            throw new InvalidOperationException("Erreur lors de la modification du stock", ex);
        }
    }

    public async Task<bool> SupprimerProduitAsync(int produitId)
    {
        try
        {
            return await _produitRepository.DeleteAsync(produitId);
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("Erreur lors de la suppression du produit", ex);
        }
    }
}
