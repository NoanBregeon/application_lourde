namespace application_lourde.Models;

public class PreparationLigne
{
    public int Id { get; set; }
    public int PreparationId { get; set; }
    public int CommandeLigneId { get; set; }
    public int QuantitePreparee { get; set; }
    public bool EnRupture { get; set; }
}
