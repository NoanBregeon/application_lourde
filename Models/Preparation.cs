namespace application_lourde.Models;

public class Preparation
{
    public int Id { get; set; }
    public int CommandeId { get; set; }
    public DateTime DatePreparation { get; set; }
    public string Statut { get; set; } = "EN_COURS";
}
