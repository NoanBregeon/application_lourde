using application_lourde.DAL;
using application_lourde.Models;

namespace application_lourde.Services;

public class CommandeService : ICommandeService
{
    private readonly ICommandeRepository _commandeRepository;

    public CommandeService(ICommandeRepository commandeRepository)
    {
        _commandeRepository = commandeRepository;
    }

    public async Task<IEnumerable<Commande>> GetCommandesAPreparerAsync()
    {
        try
        {
            return await _commandeRepository.GetCommandesAPreparerAsync();
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("Erreur lors de la récupération des commandes à préparer", ex);
        }
    }

    public async Task<IEnumerable<Commande>> GetHistoriqueCommandesAsync()
    {
        try
        {
            return await _commandeRepository.GetHistoriqueAsync();
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("Erreur lors de la récupération de l'historique", ex);
        }
    }

    public async Task<Commande?> GetCommandeByIdAsync(int commandeId)
    {
        try
        {
            return await _commandeRepository.GetByIdAsync(commandeId);
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("Erreur lors de la récupération de la commande", ex);
        }
    }

    public async Task<IEnumerable<CommandeLigne>> GetLignesCommandeAsync(int commandeId)
    {
        try
        {
            return await _commandeRepository.GetLignesAsync(commandeId);
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("Erreur lors de la récupération des lignes de commande", ex);
        }
    }

    public async Task<int> DemarrerPreparationAsync(int commandeId)
    {
        try
        {
            return await _commandeRepository.CreatePreparationAsync(commandeId);
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("Erreur lors du démarrage de la préparation", ex);
        }
    }

    public async Task<bool> ValiderLigneAsync(int preparationId, int commandeLigneId, int quantitePreparee)
    {
        try
        {
            if (quantitePreparee < 0)
                throw new ArgumentException("La quantité préparée ne peut pas être négative");

            return await _commandeRepository.UpdateLignePreparationAsync(preparationId, commandeLigneId, quantitePreparee, false);
        }
        catch (Exception ex) when (ex is not ArgumentException)
        {
            throw new InvalidOperationException("Erreur lors de la validation de la ligne", ex);
        }
    }

    public async Task<bool> MarquerLigneRuptureAsync(int preparationId, int commandeLigneId)
    {
        try
        {
            return await _commandeRepository.UpdateLignePreparationAsync(preparationId, commandeLigneId, 0, true);
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("Erreur lors du marquage en rupture", ex);
        }
    }

    public async Task<bool> FinaliserCommandeAsync(int commandeId)
    {
        try
        {
            return await _commandeRepository.FinaliserCommandeAsync(commandeId);
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("Erreur lors de la finalisation de la commande", ex);
        }
    }
}
