using application_lourde.Models;

namespace application_lourde.Services;

public interface ICommandeService
{
    Task<IEnumerable<Commande>> GetCommandesAPreparerAsync();
    Task<IEnumerable<Commande>> GetHistoriqueCommandesAsync();
    Task<Commande?> GetCommandeByIdAsync(int commandeId);
    Task<IEnumerable<CommandeLigne>> GetLignesCommandeAsync(int commandeId);
    Task<int> DemarrerPreparationAsync(int commandeId);
    Task<bool> ValiderLigneAsync(int preparationId, int commandeLigneId, int quantitePreparee);
    Task<bool> MarquerLigneRuptureAsync(int preparationId, int commandeLigneId);
    Task<bool> FinaliserCommandeAsync(int commandeId);
}
