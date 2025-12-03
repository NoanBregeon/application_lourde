using MySqlConnector;
using System.Data;

namespace application_lourde.DAL;

public class MariaDbConnector : IDbConnector
{
    private readonly string _connectionString;

    public MariaDbConnector(string connectionString)
    {
        _connectionString = connectionString ?? throw new ArgumentNullException(nameof(connectionString));
    }

    public IDbConnection CreateConnection()
    {
        return new MySqlConnection(_connectionString);
    }
}
