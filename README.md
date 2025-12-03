# Application de Gestion Drive - Stock & Commandes

Application WPF .NET 8 pour la gestion du stock et la préparation des commandes Drive.

## Architecture

```
application_lourde/
??? Models/                     # Modèles de données
?   ??? Produit.cs
?   ??? Commande.cs
?   ??? CommandeLigne.cs
?   ??? Preparation.cs
?   ??? PreparationLigne.cs
??? DAL/                        # Couche d'accès aux données
?   ??? IDbConnector.cs
?   ??? MariaDbConnector.cs
?   ??? IProduitRepository.cs
?   ??? ProduitRepository.cs
?   ??? ICommandeRepository.cs
?   ??? CommandeRepository.cs
??? Services/                   # Couche métier
?   ??? IStockService.cs
?   ??? StockService.cs
?   ??? ICommandeService.cs
?   ??? CommandeService.cs
??? ViewModels/                 # ViewModels MVVM
?   ??? ViewModelBase.cs
?   ??? RelayCommand.cs
?   ??? MainViewModel.cs
?   ??? StockViewModel.cs
?   ??? CommandeViewModel.cs
??? Views/                      # Vues WPF
?   ??? MainWindow.xaml/.cs
?   ??? StockView.xaml/.cs
?   ??? CommandeView.xaml/.cs
??? Converters/                 # Convertisseurs WPF
?   ??? InverseBooleanToVisibilityConverter.cs
?   ??? BoolToRuptureConverter.cs
??? App.xaml/.cs               # Point d'entrée de l'application
??? appsettings.json           # Configuration
??? database_setup.sql         # Script de création de la base de données
```

## Prérequis

- .NET 8 SDK
- MariaDB ou MySQL
- Visual Studio 2022 (recommandé)

## Installation

### 1. Base de données

1. Installer MariaDB ou MySQL
2. Exécuter le script `database_setup.sql` :
```bash
mysql -u root -p < database_setup.sql
```

### 2. Configuration

Modifier le fichier `appsettings.json` avec vos paramètres de connexion :

```json
{
  "ConnectionStrings": {
    "MariaDb": "Server=localhost;Port=3306;Database=drive_db;User=root;Password=VOTRE_MOT_DE_PASSE;"
  }
}
```

### 3. Compilation et exécution

```bash
dotnet restore
dotnet build
dotnet run
```

Ou ouvrir `application_lourde.csproj` dans Visual Studio et appuyer sur F5.

## Fonctionnalités

### Module 1 : Gestion du Stock

- ? Affichage de tous les produits
- ? Recherche par libellé ou référence
- ? Tri automatique par libellé
- ? Ajout de produit (libellé, référence, prix HT, TVA, stock)
- ? Modification de produit
- ? Modification rapide du stock
- ? Suppression de produit avec confirmation
- ? Affichage automatique des produits en stock faible (< 5)
- ? Calcul automatique du prix TTC

### Module 2 : Préparation des Commandes Drive

- ? Affichage des commandes à préparer
- ? Détail d'une commande avec toutes ses lignes
- ? Affichage : produit, quantité demandée, stock disponible, quantité préparée
- ? Validation d'une ligne avec saisie de la quantité préparée
- ? Marquage d'une ligne en rupture
- ? Mise à jour automatique du stock lors de la préparation
- ? Finalisation d'une commande ? statut "PRÊTE"
- ? Affichage de l'historique des commandes préparées
- ? Indication visuelle des ruptures de stock

## Structure de la base de données

### Table `produits`
- `id` : Identifiant unique
- `libelle` : Nom du produit
- `reference` : Référence unique
- `prix_ht` : Prix hors taxes
- `taux_tva` : Taux de TVA (%)
- `stock` : Quantité en stock

### Table `commandes`
- `id` : Identifiant unique
- `numero` : Numéro de commande
- `client` : Nom du client
- `creneau` : Date/heure du créneau
- `statut` : EN_ATTENTE, EN_PREPARATION, PRETE, ANNULEE

### Table `commande_lignes`
- `id` : Identifiant unique
- `commande_id` : Référence à la commande
- `produit_id` : Référence au produit
- `quantite_demandee` : Quantité commandée

### Table `preparations`
- `id` : Identifiant unique
- `commande_id` : Référence à la commande
- `date_preparation` : Date de préparation
- `statut` : EN_COURS, TERMINEE, ANNULEE

### Table `preparation_lignes`
- `id` : Identifiant unique
- `preparation_id` : Référence à la préparation
- `commande_ligne_id` : Référence à la ligne de commande
- `quantite_preparee` : Quantité effectivement préparée
- `en_rupture` : Indicateur de rupture (booléen)

## Technologies utilisées

- **.NET 8** : Framework principal
- **WPF** : Interface utilisateur
- **MVVM** : Pattern architectural
- **Dapper** : ORM léger pour l'accès aux données
- **MySqlConnector** : Connecteur MariaDB/MySQL
- **Microsoft.Extensions.DependencyInjection** : Injection de dépendances
- **Microsoft.Extensions.Configuration** : Gestion de la configuration

## Principes de conception

- **Séparation des responsabilités** : Architecture en couches (UI, ViewModels, Services, DAL, Models)
- **Injection de dépendances** : Facilite les tests et la maintenance
- **Pattern MVVM** : Séparation claire entre la logique et la présentation
- **Pattern Repository** : Abstraction de l'accès aux données
- **Gestion des erreurs** : Try/catch avec affichage de messages utilisateur clairs
- **Async/Await** : Opérations asynchrones pour une interface réactive

## Données de test

Le script `database_setup.sql` inclut des données de test :
- 10 produits (dont certains en stock faible)
- 5 commandes (3 à préparer, 2 dans l'historique)
- Lignes de commande associées

## Interface utilisateur

L'interface utilise un style moderne et épuré avec :
- **Couleurs** : Bleu (#0078D4) pour les actions principales, Rouge (#D13438) pour les actions dangereuses
- **Typographie** : Police claire et lisible, tailles adaptées
- **DataGrid** : Mise en forme professionnelle avec alternance de couleurs
- **Indicateurs visuels** : Stock faible en rouge, statuts avec codes couleur
- **Feedback utilisateur** : Messages de confirmation et d'erreur clairs

## Maintenance

Pour ajouter de nouvelles fonctionnalités :
1. Créer le modèle dans `Models/`
2. Ajouter les méthodes repository dans `DAL/`
3. Implémenter la logique métier dans `Services/`
4. Créer le ViewModel dans `ViewModels/`
5. Créer la vue dans `Views/`
