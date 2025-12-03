using application_lourde.Models;

namespace application_lourde.DAL;

public interface ICommandeRepository
{
    Task<IEnumerable<Commande>> GetAllAsync();
    Task<Commande?> GetByIdAsync(int id);
    Task<IEnumerable<CommandeLigne>> GetLignesAsync(int commandeId);
    Task<IEnumerable<Commande>> GetCommandesAPreparerAsync();
    Task<IEnumerable<Commande>> GetHistoriqueAsync();
    Task<int> CreatePreparationAsync(int commandeId);
    Task<bool> UpdateLignePreparationAsync(int preparationId, int commandeLigneId, int quantite, bool enRupture);
    Task<bool> FinaliserCommandeAsync(int commandeId);
}
