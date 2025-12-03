using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using application_lourde.DAL;
using application_lourde.Services;
using application_lourde.ViewModels;
using application_lourde.Views;

namespace application_lourde.Infrastructure;

public static class ServiceCollectionExtensions
{
    // Centralise les registrations de services / repository / viewmodels
    public static IServiceCollection AddFrameworkAdapters(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddSingleton(configuration);

        services.AddSingleton<IDbConnector>(sp =>
            new MariaDbConnector(configuration.GetConnectionString("MariaDb")!));

        services.AddTransient<IProduitRepository, ProduitRepository>();
        services.AddTransient<ICommandeRepository, CommandeRepository>();

        services.AddTransient<IStockService, StockService>();
        services.AddTransient<ICommandeService, CommandeService>();

        // ViewModels
        services.AddTransient<MainViewModel>();
        services.AddTransient<StockViewModel>();
        services.AddTransient<CommandeViewModel>();

        // Views
        services.AddTransient<MainWindow>();

        return services;
    }
}
