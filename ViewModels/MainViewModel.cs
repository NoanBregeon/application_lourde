using System.Windows.Input;
using CommunityToolkit.Mvvm.ComponentModel;

namespace application_lourde.ViewModels;

public class MainViewModel : ObservableObject
{
    private object? _currentView;

    public object? CurrentView
    {
        get => _currentView;
        set => SetProperty(ref _currentView, value);
    }

    public ICommand NavigateToStockCommand { get; }
    public ICommand NavigateToCommandesCommand { get; }

    private readonly StockViewModel _stockViewModel;
    private readonly CommandeViewModel _commandeViewModel;

    public MainViewModel(StockViewModel stockViewModel, CommandeViewModel commandeViewModel)
    {
        _stockViewModel = stockViewModel;
        _commandeViewModel = commandeViewModel;

        NavigateToStockCommand = new RelayCommand(_ => NavigateToStock());
        NavigateToCommandesCommand = new RelayCommand(_ => NavigateToCommandes());

        NavigateToStock();
    }

    private void NavigateToStock()
    {
        CurrentView = _stockViewModel;
        _stockViewModel.LoadDataAsync();
    }

    private void NavigateToCommandes()
    {
        CurrentView = _commandeViewModel;
        _commandeViewModel.LoadDataAsync();
    }
}
