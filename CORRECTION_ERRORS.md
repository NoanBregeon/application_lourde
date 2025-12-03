# GUIDE DE CORRECTION DES ERREURS

## Problèmes identifiés

1. **Form1.cs** - Fichier Windows Forms inutile pour l'application WPF
2. **StockView.xaml et CommandeView.xaml** - Problèmes d'encodage et de structure XML

## SOLUTION 1 : Supprimer Form1.cs

Supprimez manuellement le fichier `Form1.cs` car il n'est pas utilisé dans l'application WPF.

## SOLUTION 2 : Corriger StockView.xaml

Remplacez TOUT le contenu de `Views/StockView.xaml` par ce code :

```xaml
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

            <StackPanel Grid.Column="0" Orientation="Horizontal">
                <TextBlock Text="Recherche:" FontSize="16" VerticalAlignment="Center" Margin="5,0"/>
                <TextBox Width="300" Text="{Binding RechercheTexte, UpdateSourceTrigger=PropertyChanged}" VerticalContentAlignment="Center" Padding="8,5" Margin="5" FontSize="13" BorderBrush="#CCCCCC" BorderThickness="1"/>
            </StackPanel>

            <StackPanel Grid.Column="1" Orientation="Horizontal">
                <Button Content="+ Ajouter" Command="{Binding AjouterProduitCommand}" Width="120"/>
                <Button Content="Modifier" Command="{Binding ModifierProduitCommand}" Width="120"/>
                <Button Content="Stock" Command="{Binding ModifierStockCommand}" Width="120"/>
                <Button Content="Supprimer" Command="{Binding SupprimerProduitCommand}" Style="{StaticResource DangerButton}" Width="120"/>
            </StackPanel>
        </Grid>

        <Border Grid.Row="2" BorderBrush="#DDDDDD" BorderThickness="1" Margin="0,0,0,15">
            <DataGrid ItemsSource="{Binding Produits}" SelectedItem="{Binding ProduitSelectionne}">
                <DataGrid.Columns>
                    <DataGridTextColumn Header="Libelle" Binding="{Binding Libelle}" Width="*" MinWidth="150"/>
                    <DataGridTextColumn Header="Reference" Binding="{Binding Reference}" Width="120"/>
                    <DataGridTextColumn Header="Prix HT" Binding="{Binding PrixHT, StringFormat='{}{0:N2} EUR'}" Width="100"/>
                    <DataGridTextColumn Header="TVA %" Binding="{Binding TauxTVA, StringFormat='{}{0:N2}'}" Width="80"/>
                    <DataGridTextColumn Header="Prix TTC" Binding="{Binding PrixTTC, StringFormat='{}{0:N2} EUR'}" Width="100"/>
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
        </Border>

        <TextBlock Grid.Row="3" Text="PRODUITS EN STOCK FAIBLE (moins de 5)" FontSize="16" FontWeight="SemiBold" Foreground="#D13438" Margin="0,0,0,10"/>

        <Border Grid.Row="4" BorderBrush="#DDDDDD" BorderThickness="1">
            <DataGrid ItemsSource="{Binding ProduitsStockFaible}">
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
        </Border>
    </Grid>
</UserControl>
```

## SOLUTION 3 : Corriger CommandeView.xaml

Remplacez TOUT le contenu de `Views/CommandeView.xaml` par ce code :

```xaml
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

        <CheckBox Grid.Row="1" Content="Afficher l'historique des commandes preparees" IsChecked="{Binding AfficherHistorique}" FontSize="14" Margin="0,0,0,15"/>

        <Border Grid.Row="2" BorderBrush="#DDDDDD" BorderThickness="1" Margin="0,0,0,15">
            <Grid>
                <DataGrid ItemsSource="{Binding Commandes}" SelectedItem="{Binding CommandeSelectionnee}" Visibility="{Binding AfficherHistorique, Converter={StaticResource InverseBoolToVisConverter}}">
                    <DataGrid.Columns>
                        <DataGridTextColumn Header="Numero" Binding="{Binding Numero}" Width="120"/>
                        <DataGridTextColumn Header="Client" Binding="{Binding Client}" Width="*" MinWidth="150"/>
                        <DataGridTextColumn Header="Creneau" Binding="{Binding Creneau, StringFormat='{}{0:dd/MM/yyyy HH:mm}'}" Width="150"/>
                        <DataGridTextColumn Header="Statut" Binding="{Binding Statut}" Width="130">
                            <DataGridTextColumn.ElementStyle>
                                <Style TargetType="TextBlock">
                                    <Style.Triggers>
                                        <DataTrigger Binding="{Binding Statut}" Value="EN_ATTENTE">
                                            <Setter Property="Foreground" Value="#FF8C00"/>
                                            <Setter Property="FontWeight" Value="SemiBold"/>
                                        </DataTrigger>
                                        <DataTrigger Binding="{Binding Statut}" Value="EN_PREPARATION">
                                            <Setter Property="Foreground" Value="#0078D4"/>
                                            <Setter Property="FontWeight" Value="SemiBold"/>
                                        </DataTrigger>
                                        <DataTrigger Binding="{Binding Statut}" Value="PRETE">
                                            <Setter Property="Foreground" Value="#107C10"/>
                                            <Setter Property="FontWeight" Value="SemiBold"/>
                                        </DataTrigger>
                                    </Style.Triggers>
                                </Style>
                            </DataGridTextColumn.ElementStyle>
                        </DataGridTextColumn>
                    </DataGrid.Columns>
                </DataGrid>
                
                <DataGrid ItemsSource="{Binding Historique}" Visibility="{Binding AfficherHistorique, Converter={StaticResource BoolToVisConverter}}">
                    <DataGrid.Columns>
                        <DataGridTextColumn Header="Numero" Binding="{Binding Numero}" Width="120"/>
                        <DataGridTextColumn Header="Client" Binding="{Binding Client}" Width="*" MinWidth="150"/>
                        <DataGridTextColumn Header="Creneau" Binding="{Binding Creneau, StringFormat='{}{0:dd/MM/yyyy HH:mm}'}" Width="150"/>
                        <DataGridTextColumn Header="Statut" Binding="{Binding Statut}" Width="130">
                            <DataGridTextColumn.ElementStyle>
                                <Style TargetType="TextBlock">
                                    <Setter Property="Foreground" Value="#107C10"/>
                                    <Setter Property="FontWeight" Value="SemiBold"/>
                                </Style>
                            </DataGridTextColumn.ElementStyle>
                        </DataGridTextColumn>
                    </DataGrid.Columns>
                </DataGrid>
            </Grid>
        </Border>

        <Grid Grid.Row="3" Margin="0,0,0,10">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="Auto"/>
            </Grid.ColumnDefinitions>

            <StackPanel Grid.Column="0" Orientation="Horizontal">
                <TextBlock Text="DETAIL DE LA COMMANDE" FontSize="16" FontWeight="SemiBold" Foreground="#2C3E50" VerticalAlignment="Center"/>
                <TextBlock Text="{Binding CommandeSelectionnee.Numero, StringFormat=' - N° {0}', Mode=OneWay, FallbackValue=''}" FontSize="16" FontWeight="Bold" Foreground="#2C3E50" VerticalAlignment="Center" Margin="5,0,0,0"/>
            </StackPanel>

            <Button Grid.Column="1" Content="FINALISER LA COMMANDE" Command="{Binding FinaliserCommandeCommand}" Width="200" Height="35" Background="#107C10" FontWeight="Bold"/>
        </Grid>

        <Border Grid.Row="4" BorderBrush="#DDDDDD" BorderThickness="1" Margin="0,0,0,15">
            <DataGrid ItemsSource="{Binding LignesCommande}" SelectedItem="{Binding LigneSelectionnee}">
                <DataGrid.Columns>
                    <DataGridTextColumn Header="Produit" Binding="{Binding ProduitLibelle}" Width="*" MinWidth="200"/>
                    <DataGridTextColumn Header="Qte demandee" Binding="{Binding QuantiteDemandee}" Width="120"/>
                    <DataGridTextColumn Header="Stock dispo" Binding="{Binding StockDisponible}" Width="110">
                        <DataGridTextColumn.ElementStyle>
                            <Style TargetType="TextBlock">
                                <Style.Triggers>
                                    <DataTrigger Binding="{Binding StockDisponible}" Value="0">
                                        <Setter Property="Foreground" Value="#D13438"/>
                                        <Setter Property="FontWeight" Value="Bold"/>
                                    </DataTrigger>
                                </Style.Triggers>
                            </Style>
                        </DataGridTextColumn.ElementStyle>
                    </DataGridTextColumn>
                    <DataGridTextColumn Header="Qte preparee" Binding="{Binding QuantitePreparee}" Width="120">
                        <DataGridTextColumn.ElementStyle>
                            <Style TargetType="TextBlock">
                                <Style.Triggers>
                                    <DataTrigger Binding="{Binding QuantitePreparee}" Value="0">
                                        <Setter Property="Foreground" Value="#888888"/>
                                    </DataTrigger>
                                </Style.Triggers>
                            </Style>
                        </DataGridTextColumn.ElementStyle>
                    </DataGridTextColumn>
                    <DataGridTemplateColumn Header="Rupture" Width="80">
                        <DataGridTemplateColumn.CellTemplate>
                            <DataTemplate>
                                <TextBlock Text="{Binding EnRupture, Converter={StaticResource BoolToRuptureConverter}}" HorizontalAlignment="Center">
                                    <TextBlock.Style>
                                        <Style TargetType="TextBlock">
                                            <Style.Triggers>
                                                <DataTrigger Binding="{Binding EnRupture}" Value="True">
                                                    <Setter Property="Foreground" Value="#D13438"/>
                                                    <Setter Property="FontWeight" Value="Bold"/>
                                                </DataTrigger>
                                            </Style.Triggers>
                                        </Style>
                                    </TextBlock.Style>
                                </TextBlock>
                            </DataTemplate>
                        </DataGridTemplateColumn.CellTemplate>
                    </DataGridTemplateColumn>
                </DataGrid.Columns>
            </DataGrid>
        </Border>

        <StackPanel Grid.Row="5" Orientation="Horizontal" HorizontalAlignment="Right">
            <Button Content="Valider la ligne" Command="{Binding ValiderLigneCommand}" Width="150" Background="#107C10"/>
            <Button Content="Marquer en rupture" Command="{Binding MarquerRuptureCommand}" Style="{StaticResource DangerButton}" Width="170"/>
        </StackPanel>
    </Grid>
</UserControl>
```

## SOLUTION 4 : Vérifier appsettings.json

Assurez-vous que `appsettings.json` contient la bonne chaîne de connexion :

```json
{
  "ConnectionStrings": {
    "MariaDb": "Server=localhost;Port=3306;Database=drive_db;User=root;Password=VOTRE_MOT_DE_PASSE;"
  }
}
```

## Instructions après correction

1. Supprimez `Form1.cs`
2. Remplacez le contenu de `Views/StockView.xaml`
3. Remplacez le contenu de `Views/CommandeView.xaml`
4. Rebuild la solution (Ctrl+Shift+B)
5. Exécutez le script `database_setup.sql` dans MariaDB
6. Lancez l'application (F5)

L'application devrait compiler et fonctionner correctement après ces corrections.
