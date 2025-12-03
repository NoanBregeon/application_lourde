# Script de creation COMPLETE de tous les fichiers XAML
# Encodage: UTF-8

Write-Host "=== RECREATION COMPLETE DES FICHIERS XAML ===" -ForegroundColor Green

# 1. App.xaml
$appXaml = @"
<Application x:Class="application_lourde.App"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             StartupUri="Views/MainWindow.xaml">
    <Application.Resources>
        <ResourceDictionary>
            <Style TargetType="Button">
                <Setter Property="Padding" Value="15,8"/>
                <Setter Property="Margin" Value="5"/>
                <Setter Property="Background" Value="#0078D4"/>
                <Setter Property="Foreground" Value="White"/>
                <Setter Property="FontSize" Value="14"/>
                <Setter Property="Cursor" Value="Hand"/>
                <Style.Triggers>
                    <Trigger Property="IsMouseOver" Value="True">
                        <Setter Property="Background" Value="#106EBE"/>
                    </Trigger>
                </Style.Triggers>
            </Style>
            <Style x:Key="DangerButton" TargetType="Button">
                <Setter Property="Padding" Value="15,8"/>
                <Setter Property="Margin" Value="5"/>
                <Setter Property="Background" Value="#D13438"/>
                <Setter Property="Foreground" Value="White"/>
                <Setter Property="FontSize" Value="14"/>
                <Style.Triggers>
                    <Trigger Property="IsMouseOver" Value="True">
                        <Setter Property="Background" Value="#A01E22"/>
                    </Trigger>
                </Style.Triggers>
            </Style>
            <Style TargetType="DataGrid">
                <Setter Property="AutoGenerateColumns" Value="False"/>
                <Setter Property="IsReadOnly" Value="True"/>
                <Setter Property="SelectionMode" Value="Single"/>
                <Setter Property="AlternatingRowBackground" Value="#F9F9F9"/>
                <Setter Property="FontSize" Value="13"/>
                <Setter Property="RowHeight" Value="35"/>
            </Style>
            <Style TargetType="DataGridColumnHeader">
                <Setter Property="Background" Value="#F3F3F3"/>
                <Setter Property="FontWeight" Value="SemiBold"/>
                <Setter Property="Padding" Value="10,8"/>
            </Style>
            <Style TargetType="DataGridRow">
                <Style.Triggers>
                    <Trigger Property="IsMouseOver" Value="True">
                        <Setter Property="Background" Value="#E8F4FD"/>
                    </Trigger>
                    <Trigger Property="IsSelected" Value="True">
                        <Setter Property="Background" Value="#CCE8FF"/>
                    </Trigger>
                </Style.Triggers>
            </Style>
        </ResourceDictionary>
    </Application.Resources>
</Application>
"@

# 2. MainWindow.xaml
$mainWindowXaml = @"
<Window x:Class="application_lourde.Views.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:vm="clr-namespace:application_lourde.ViewModels"
        xmlns:views="clr-namespace:application_lourde.Views"
        Title="Gestion Drive" Height="750" Width="1280" WindowStartupLocation="CenterScreen">
    <Window.Resources>
        <DataTemplate DataType="{x:Type vm:StockViewModel}">
            <views:StockView/>
        </DataTemplate>
        <DataTemplate DataType="{x:Type vm:CommandeViewModel}">
            <views:CommandeView/>
        </DataTemplate>
    </Window.Resources>
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>
        <Border Grid.Row="0" Background="#2C3E50" Padding="15,10">
            <StackPanel Orientation="Horizontal">
                <TextBlock Text="GESTION DRIVE" FontSize="22" FontWeight="Bold" Foreground="White" VerticalAlignment="Center" Margin="0,0,50,0"/>
                <Button Content="Stock" Command="{Binding NavigateToStockCommand}" Width="150" Height="40"/>
                <Button Content="Commandes" Command="{Binding NavigateToCommandesCommand}" Width="150" Height="40"/>
            </StackPanel>
        </Border>
        <ContentControl Grid.Row="1" Content="{Binding CurrentView}"/>
    </Grid>
</Window>
"@

# 3. StockView.xaml
$stockViewXaml = @"
<UserControl x:Class="application_lourde.Views.StockView"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml">
    <Grid Margin="20">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="200"/>
        </Grid.RowDefinitions>
        <TextBlock Grid.Row="0" Text="GESTION DU STOCK" FontSize="24" FontWeight="Bold" Foreground="#2C3E50" Margin="0,0,0,20"/>
        <Grid Grid.Row="1" Margin="0,0,0,15">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="Auto"/>
            </Grid.ColumnDefinitions>
            <TextBox Grid.Column="0" Width="300" HorizontalAlignment="Left" Text="{Binding RechercheTexte, UpdateSourceTrigger=PropertyChanged}" Padding="8,5" Margin="5"/>
            <StackPanel Grid.Column="1" Orientation="Horizontal">
                <Button Content="Ajouter" Command="{Binding AjouterProduitCommand}" Width="120"/>
                <Button Content="Modifier" Command="{Binding ModifierProduitCommand}" Width="120"/>
                <Button Content="Stock" Command="{Binding ModifierStockCommand}" Width="120"/>
                <Button Content="Supprimer" Command="{Binding SupprimerProduitCommand}" Style="{StaticResource DangerButton}" Width="120"/>
            </StackPanel>
        </Grid>
        <DataGrid Grid.Row="2" ItemsSource="{Binding Produits}" SelectedItem="{Binding ProduitSelectionne}" Margin="0,0,0,15">
            <DataGrid.Columns>
                <DataGridTextColumn Header="Libelle" Binding="{Binding Libelle}" Width="*" MinWidth="150"/>
                <DataGridTextColumn Header="Reference" Binding="{Binding Reference}" Width="120"/>
                <DataGridTextColumn Header="Prix HT" Binding="{Binding PrixHT, StringFormat='{}{0:N2}'}" Width="100"/>
                <DataGridTextColumn Header="TVA" Binding="{Binding TauxTVA, StringFormat='{}{0:N2}'}" Width="80"/>
                <DataGridTextColumn Header="Prix TTC" Binding="{Binding PrixTTC, StringFormat='{}{0:N2}'}" Width="100"/>
                <DataGridTextColumn Header="Stock" Binding="{Binding Stock}" Width="80">
                    <DataGridTextColumn.ElementStyle>
                        <Style TargetType="TextBlock">
                            <Style.Triggers>
                                <DataTrigger Binding="{Binding StockFaible}" Value="True">
                                    <Setter Property="Foreground" Value="#D13438"/>
                                    <Setter Property="FontWeight" Value="Bold"/>
                                </DataTrigger>
                            </Style.Triggers>
                        </Style>
                    </DataGridTextColumn.ElementStyle>
                </DataGridTextColumn>
            </DataGrid.Columns>
        </DataGrid>
        <TextBlock Grid.Row="3" Text="PRODUITS EN STOCK FAIBLE" FontSize="16" FontWeight="SemiBold" Foreground="#D13438" Margin="0,0,0,10"/>
        <DataGrid Grid.Row="4" ItemsSource="{Binding ProduitsStockFaible}">
            <DataGrid.Columns>
                <DataGridTextColumn Header="Libelle" Binding="{Binding Libelle}" Width="*" MinWidth="150"/>
                <DataGridTextColumn Header="Reference" Binding="{Binding Reference}" Width="120"/>
                <DataGridTextColumn Header="Stock" Binding="{Binding Stock}" Width="80">
                    <DataGridTextColumn.ElementStyle>
                        <Style TargetType="TextBlock">
                            <Setter Property="Foreground" Value="#D13438"/>
                            <Setter Property="FontWeight" Value="Bold"/>
                        </Style>
                    </DataGridTextColumn.ElementStyle>
                </DataGridTextColumn>
            </DataGrid.Columns>
        </DataGrid>
    </Grid>
</UserControl>
"@

# 4. CommandeView.xaml
$commandeViewXaml = @"
<UserControl x:Class="application_lourde.Views.CommandeView"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:converters="clr-namespace:application_lourde.Converters">
    <UserControl.Resources>
        <BooleanToVisibilityConverter x:Key="BoolToVisConverter"/>
        <converters:InverseBooleanToVisibilityConverter x:Key="InverseBoolToVisConverter"/>
        <converters:BoolToRuptureConverter x:Key="BoolToRuptureConverter"/>
    </UserControl.Resources>
    <Grid Margin="20">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="250"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        <TextBlock Grid.Row="0" Text="PREPARATION DES COMMANDES DRIVE" FontSize="24" FontWeight="Bold" Foreground="#2C3E50" Margin="0,0,0,20"/>
        <CheckBox Grid.Row="1" Content="Afficher historique" IsChecked="{Binding AfficherHistorique}" FontSize="14" Margin="0,0,0,15"/>
        <Grid Grid.Row="2" Margin="0,0,0,15">
            <DataGrid ItemsSource="{Binding Commandes}" SelectedItem="{Binding CommandeSelectionnee}" Visibility="{Binding AfficherHistorique, Converter={StaticResource InverseBoolToVisConverter}}">
                <DataGrid.Columns>
                    <DataGridTextColumn Header="Numero" Binding="{Binding Numero}" Width="120"/>
                    <DataGridTextColumn Header="Client" Binding="{Binding Client}" Width="*" MinWidth="150"/>
                    <DataGridTextColumn Header="Creneau" Binding="{Binding Creneau, StringFormat='{}{0:dd/MM/yyyy HH:mm}'}" Width="150"/>
                    <DataGridTextColumn Header="Statut" Binding="{Binding Statut}" Width="130"/>
                </DataGrid.Columns>
            </DataGrid>
            <DataGrid ItemsSource="{Binding Historique}" Visibility="{Binding AfficherHistorique, Converter={StaticResource BoolToVisConverter}}">
                <DataGrid.Columns>
                    <DataGridTextColumn Header="Numero" Binding="{Binding Numero}" Width="120"/>
                    <DataGridTextColumn Header="Client" Binding="{Binding Client}" Width="*" MinWidth="150"/>
                    <DataGridTextColumn Header="Creneau" Binding="{Binding Creneau, StringFormat='{}{0:dd/MM/yyyy HH:mm}'}" Width="150"/>
                    <DataGridTextColumn Header="Statut" Binding="{Binding Statut}" Width="130"/>
                </DataGrid.Columns>
            </DataGrid>
        </Grid>
        <Grid Grid.Row="3" Margin="0,0,0,10">
            <TextBlock Text="DETAIL DE LA COMMANDE" FontSize="16" FontWeight="SemiBold" Foreground="#2C3E50" HorizontalAlignment="Left"/>
            <Button Content="FINALISER" Command="{Binding FinaliserCommandeCommand}" Width="150" Height="35" Background="#107C10" HorizontalAlignment="Right"/>
        </Grid>
        <DataGrid Grid.Row="4" ItemsSource="{Binding LignesCommande}" SelectedItem="{Binding LigneSelectionnee}" Margin="0,0,0,15">
            <DataGrid.Columns>
                <DataGridTextColumn Header="Produit" Binding="{Binding ProduitLibelle}" Width="*" MinWidth="200"/>
                <DataGridTextColumn Header="Qte demandee" Binding="{Binding QuantiteDemandee}" Width="120"/>
                <DataGridTextColumn Header="Stock dispo" Binding="{Binding StockDisponible}" Width="110"/>
                <DataGridTextColumn Header="Qte preparee" Binding="{Binding QuantitePreparee}" Width="120"/>
                <DataGridTemplateColumn Header="Rupture" Width="80">
                    <DataGridTemplateColumn.CellTemplate>
                        <DataTemplate>
                            <TextBlock Text="{Binding EnRupture, Converter={StaticResource BoolToRuptureConverter}}" HorizontalAlignment="Center"/>
                        </DataTemplate>
                    </DataGridTemplateColumn.CellTemplate>
                </DataGridTemplateColumn>
            </DataGrid.Columns>
        </DataGrid>
        <StackPanel Grid.Row="5" Orientation="Horizontal" HorizontalAlignment="Right">
            <Button Content="Valider ligne" Command="{Binding ValiderLigneCommand}" Width="150" Background="#107C10"/>
            <Button Content="Marquer rupture" Command="{Binding MarquerRuptureCommand}" Style="{StaticResource DangerButton}" Width="170"/>
        </StackPanel>
    </Grid>
</UserControl>
"@

# Creation des fichiers
Write-Host "1/4 Creation App.xaml..." -ForegroundColor Yellow
[System.IO.File]::WriteAllText("$PSScriptRoot\App.xaml", $appXaml, [System.Text.Encoding]::UTF8)
Write-Host "    OK" -ForegroundColor Green

Write-Host "2/4 Creation Views\MainWindow.xaml..." -ForegroundColor Yellow
if (-not (Test-Path "$PSScriptRoot\Views")) {
    New-Item -Path "$PSScriptRoot\Views" -ItemType Directory -Force | Out-Null
}
[System.IO.File]::WriteAllText("$PSScriptRoot\Views\MainWindow.xaml", $mainWindowXaml, [System.Text.Encoding]::UTF8)
Write-Host "    OK" -ForegroundColor Green

Write-Host "3/4 Creation Views\StockView.xaml..." -ForegroundColor Yellow
[System.IO.File]::WriteAllText("$PSScriptRoot\Views\StockView.xaml", $stockViewXaml, [System.Text.Encoding]::UTF8)
Write-Host "    OK" -ForegroundColor Green

Write-Host "4/4 Creation Views\CommandeView.xaml..." -ForegroundColor Yellow
[System.IO.File]::WriteAllText("$PSScriptRoot\Views\CommandeView.xaml", $commandeViewXaml, [System.Text.Encoding]::UTF8)
Write-Host "    OK" -ForegroundColor Green

Write-Host ""
Write-Host "=== TOUS LES FICHIERS XAML SONT CREES ===" -ForegroundColor Green
Write-Host ""
Write-Host "PROCHAINE ETAPE:" -ForegroundColor Cyan
Write-Host "  Dans Visual Studio: Build > Rebuild Solution (Ctrl+Shift+B)" -ForegroundColor White
Write-Host "  Puis appuyez sur F5 pour lancer l'application" -ForegroundColor White
Write-Host ""
