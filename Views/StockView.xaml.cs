using System.Windows.Controls;
using System.Windows;
using application_lourde.ViewModels;

namespace application_lourde.Views;

public partial class StockView : UserControl
{
    private bool _initialized;

    public StockView()
    {
        InitializeComponent();
        Loaded += StockView_Loaded;
    }

    private void StockView_Loaded(object? sender, RoutedEventArgs e)
    {
        if (_initialized) return;
        _initialized = true;

        if (DataContext is StockViewModel vm)
        {
            // Fire-and-forget async load; ViewModel guards repeated calls
            vm.LoadDataAsync();
        }
    }
}
