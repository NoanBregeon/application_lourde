using System.Data;

namespace application_lourde.DAL;

public interface IDbConnector
{
    IDbConnection CreateConnection();
}
