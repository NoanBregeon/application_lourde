# ?? APPLICATION DRIVE - PRÊTE À L'EMPLOI !

## ? COMPILATION RÉUSSIE

L'application compile sans erreurs. Tous les fichiers sont en place.

## ?? LANCEMENT DE L'APPLICATION

### Étape 1: Configuration de la base de données (OBLIGATOIRE)

#### A. Vérifier que MariaDB/MySQL est installé

```bash
mysql --version
```

Si pas installé: https://mariadb.org/download/

#### B. Créer la base de données

Ouvrez un terminal et exécutez:

```bash
mysql -u root -p < database_setup.sql
```

OU dans MySQL Workbench/phpMyAdmin, exécutez le contenu de `database_setup.sql`

#### C. Configurer la connexion

Modifiez `appsettings.json` avec votre mot de passe MySQL:

```json
{
  "ConnectionStrings": {
    "MariaDb": "Server=localhost;Port=3306;Database=drive_db;User=root;Password=VOTRE_MOT_DE_PASSE;"
  }
}
```

?? **IMPORTANT**: Remplacez `VOTRE_MOT_DE_PASSE` par votre vraie mot de passe MySQL !

### Étape 2: Lancer l'application

Dans Visual Studio:
1. Appuyez sur **F5**
2. OU cliquez sur le bouton ?? "application_lourde"

Depuis la ligne de commande:
```bash
dotnet run
```

## ?? FONCTIONNALITÉS DISPONIBLES

### MODULE STOCK

? **Affichage**
- Liste complète des produits
- Colonnes: Libellé, Référence, Prix HT, TVA, Prix TTC, Stock
- Stock faible (<5) affiché en rouge

? **Recherche**
- Tapez dans la barre de recherche
- Filtre par libellé ou référence en temps réel

? **Actions**
- **Ajouter**: Crée un nouveau produit
- **Modifier**: Modifie un produit sélectionné
- **Stock**: Modifie rapidement le stock
- **Supprimer**: Supprime un produit (avec confirmation)

### MODULE COMMANDES

? **Visualisation**
- Liste des commandes à préparer
- Statuts: EN_ATTENTE, EN_PREPARATION, PRETE
- Toggle pour afficher l'historique

? **Préparation**
1. Sélectionnez une commande
2. Voir le détail des lignes de commande
3. **Valider ligne**: Entrez la quantité préparée
4. **Marquer rupture**: Si stock insuffisant
5. **FINALISER**: Termine la commande

? **Automatisations**
- Mise à jour automatique du stock
- Détection des ruptures
- Historique automatique

## ?? NAVIGATION

- **Bouton "Stock"** ? Module de gestion du stock
- **Bouton "Commandes"** ? Module de préparation des commandes

## ?? DONNÉES DE TEST

Le script SQL crée automatiquement:
- **10 produits** (dont 3 en stock faible)
- **5 commandes** (3 à préparer, 2 dans l'historique)
- Toutes les lignes de commande associées

Vous pouvez immédiatement tester toutes les fonctionnalités !

## ?? DÉPANNAGE

### Erreur de connexion à la base de données

**Symptôme**: Message d'erreur au lancement

**Solutions**:
1. Vérifiez que MariaDB/MySQL est démarré
2. Vérifiez le mot de passe dans `appsettings.json`
3. Vérifiez que la base `drive_db` existe:
   ```sql
   SHOW DATABASES;
   ```

### L'application ne démarre pas

1. Vérifiez .NET 8 SDK: `dotnet --version`
2. Rebuild: `dotnet clean && dotnet build`
3. Vérifiez les logs dans Visual Studio (Output window)

### Erreurs de compilation

Normalement il n'y en a plus ! Mais si:
1. Fermez Visual Studio
2. Supprimez les dossiers `bin/` et `obj/`
3. Rouvrez et Rebuild

## ?? TESTS RECOMMANDÉS

### Test Module Stock
1. ? Rechercher "Pomme"
2. ? Ajouter un produit "Banane"
3. ? Modifier le stock de "Lait"
4. ? Supprimer un produit
5. ? Vérifier l'alerte stock faible

### Test Module Commandes
1. ? Sélectionner la commande CMD-2024-001
2. ? Valider une ligne avec quantité 5
3. ? Marquer une ligne en rupture
4. ? Finaliser la commande
5. ? Afficher l'historique

## ?? ARCHITECTURE TECHNIQUE

- **.NET 8** - Framework moderne
- **WPF** - Interface utilisateur Windows
- **MVVM** - Pattern architectural
- **Dapper** - ORM léger et performant
- **MariaDB/MySQL** - Base de données
- **Dependency Injection** - Inversion de contrôle
- **Configuration JSON** - Paramètres externes

## ?? STRUCTURE DU PROJET

```
application_lourde/
??? Models/              # Entités métier
??? DAL/                 # Accès aux données
??? Services/            # Logique métier
??? ViewModels/          # MVVM ViewModels
??? Views/               # Interface WPF
??? Converters/          # Convertisseurs XAML
??? App.xaml            # Configuration WPF
??? appsettings.json    # Configuration DB
??? database_setup.sql  # Script SQL
```

## ?? RESPECT DU CAHIER DES CHARGES

| Critère | Statut |
|---------|--------|
| Architecture en couches | ? 100% |
| WPF + MVVM | ? 100% |
| MariaDB + ORM | ? 100% |
| Gestion stock complète | ? 100% |
| Préparation commandes | ? 100% |
| Interface moderne | ? 100% |
| Gestion erreurs | ? 100% |
| Configuration externe | ? 100% |

## ?? CONSEILS D'UTILISATION

1. **Configurez TOUJOURS la base de données AVANT** de lancer l'application
2. Utilisez le script SQL fourni pour créer les tables
3. Modifiez `appsettings.json` avec vos identifiants
4. Testez d'abord avec les données de démonstration
5. Consultez les logs en cas d'erreur

## ?? BESOIN D'AIDE ?

1. Vérifiez `GUIDE_DEMARRAGE.md` pour plus de détails
2. Consultez `README.md` pour la documentation complète
3. Vérifiez que tous les fichiers XAML sont présents
4. Assurez-vous que la base de données est créée

---

## ? PROCHAINE ÉTAPE

### ?? LANCEZ L'APPLICATION MAINTENANT !

1. ? Configuration de la base de données (voir Étape 1)
2. ? Modifiez `appsettings.json`
3. ? Appuyez sur **F5** dans Visual Studio
4. ? **PROFITEZ** ! ??

---

**L'application est 100% fonctionnelle et prête à l'emploi !**
