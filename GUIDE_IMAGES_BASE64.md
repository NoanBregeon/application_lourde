# ??? GUIDE - Gestion des Images en Base64 pour E-Commerce

## ?? Vue d'ensemble

Ce service permet d'ajouter des produits dans une base de données MariaDB avec leurs images **converties en Base64** pour être stockées directement dans la colonne `LONGTEXT`.

---

## ??? Architecture

```
???????????????????????????????????????????????
?  Application WPF C#                         ?
?  ?????????????????????????????????????????  ?
?  ?  ProduitImageService                  ?  ?
?  ?  • AjouterProduitAsync()              ?  ?
?  ?  • ModifierProduitAsync()             ?  ?
?  ?  • ConvertirImageEnBase64()           ?  ?
?  ?????????????????????????????????????????  ?
???????????????????????????????????????????????
                   ?
                   ? MySqlConnector
        ????????????????????????
        ?  Base MariaDB        ?
        ?  Table: produits     ?
        ?  ??????????????????  ?
        ?  ? id             ?  ?
        ?  ? libelle        ?  ?
        ?  ? description    ?  ?
        ?  ? prix_ht        ?  ?
        ?  ? tva            ?  ?
        ?  ? stock          ?  ?
        ?  ? categorie      ?  ?
        ?  ? image (LONGTEXT)? ? Base64 ici
        ?  ? created_at     ?  ?
        ?  ? updated_at     ?  ?
        ?  ??????????????????  ?
        ????????????????????????
                   ?
                   ?
        ????????????????????????
        ?  Site Laravel        ?
        ?  Affiche les images  ?
        ?  depuis Base64       ?
        ????????????????????????
```

---

## ?? Installation

### 1. Installer le package NuGet

```bash
dotnet add package MySqlConnector
```

### 2. Vérifier la structure de la table

```sql
-- La table doit avoir cette structure
CREATE TABLE IF NOT EXISTS produits (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    reference VARCHAR(50) UNIQUE,
    libelle VARCHAR(150) NOT NULL,
    description TEXT,
    prix_ht DECIMAL(8,2) NOT NULL,
    tva DECIMAL(4,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    categorie VARCHAR(50),
    image LONGTEXT,  -- ? Image en Base64
    actif TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);
```

---

## ?? Utilisation

### Exemple simple

```csharp
using application_lourde.Services;

// Créer le service
var connectionString = "Server=localhost;Port=3306;Database=epreuve_e6;User=root;Password=;";
var produitService = new ProduitImageService(connectionString);

// Ajouter un produit avec image
int produitId = await produitService.AjouterProduitAsync(
    libelle: "Pommes Golden Bio",
    description: "Pommes bio fraîches de nos producteurs locaux",
    prixHT: 3.99m,
    tva: 5.5m,
    stock: 150,
    categorie: "Fruits & Légumes",
    cheminImage: @"C:\Users\MonNom\Images\pommes.jpg"
);

Console.WriteLine($"Produit ajouté avec l'ID: {produitId}");
```

### Intégration dans App.xaml.cs avec DI

```csharp
public partial class App : Application
{
    public IServiceProvider ServiceProvider { get; private set; } = null!;

    protected override void OnStartup(StartupEventArgs e)
    {
        base.OnStartup(e);

        var serviceCollection = new ServiceCollection();
        ConfigureServices(serviceCollection);
        ServiceProvider = serviceCollection.BuildServiceProvider();

        var mainWindow = ServiceProvider.GetRequiredService<MainWindow>();
        mainWindow.Show();
    }

    private void ConfigureServices(IServiceCollection services)
    {
        // Configuration existante...
        
        // Ajout du service d'images
        var connectionString = Configuration.GetConnectionString("MariaDb")!;
        services.AddSingleton(sp => new ProduitImageService(connectionString));
    }
}
```

---

## ?? Fonctionnalités disponibles

### 1. Ajouter un produit avec image

```csharp
int produitId = await produitService.AjouterProduitAsync(
    libelle: "Tomates Bio",
    description: "Tomates fraîches en grappe",
    prixHT: 2.99m,
    tva: 5.5m,
    stock: 80,
    categorie: "Fruits & Légumes",
    cheminImage: @"C:\Images\tomates.jpg"
);
```

### 2. Modifier un produit (avec ou sans nouvelle image)

```csharp
// Avec nouvelle image
bool success = await produitService.ModifierProduitAsync(
    id: 5,
    libelle: "Tomates Bio - Promo",
    description: "Tomates fraîches en grappe - En promotion",
    prixHT: 2.49m,
    tva: 5.5m,
    stock: 100,
    categorie: "Fruits & Légumes",
    cheminImage: @"C:\Images\tomates_promo.jpg" // Nouvelle image
);

// Sans changer l'image
bool success = await produitService.ModifierProduitAsync(
    id: 5,
    libelle: "Tomates Bio",
    description: "Tomates fraîches",
    prixHT: 2.99m,
    tva: 5.5m,
    stock: 80,
    categorie: "Fruits & Légumes"
    // Pas de cheminImage = l'image reste inchangée
);
```

### 3. Récupérer l'image Base64

```csharp
string? imageBase64 = await produitService.RecupererImageBase64Async(5);

if (!string.IsNullOrEmpty(imageBase64))
{
    // Afficher dans une Image WPF
    // ou sauvegarder sur disque
}
```

### 4. Sauvegarder l'image Base64 sur disque

```csharp
string imageBase64 = await produitService.RecupererImageBase64Async(5);

produitService.SauvegarderImageDepuisBase64(
    imageBase64, 
    @"C:\Export\produit_5.jpg"
);
```

---

## ?? Affichage dans Laravel (Site Web)

### Dans un contrôleur Laravel

```php
use App\Models\Produit;

public function index()
{
    $produits = Produit::where('actif', 1)->get();
    
    // L'image est déjà en Base64 dans la BD
    return view('produits.index', compact('produits'));
}
```

### Dans une vue Blade

```html
@foreach($produits as $produit)
    <div class="produit-card">
        <!-- L'image est directement utilisable en Base64 -->
        <img src="{{ $produit->image }}" 
             alt="{{ $produit->libelle }}"
             class="produit-image">
        
        <h3>{{ $produit->libelle }}</h3>
        <p>{{ number_format($produit->prix_ht * (1 + $produit->tva/100), 2) }} €</p>
        <button>Ajouter au panier</button>
    </div>
@endforeach
```

### CSS pour l'affichage

```css
.produit-image {
    width: 200px;
    height: 200px;
    object-fit: cover;
    border-radius: 8px;
}
```

---

## ?? Limitations et bonnes pratiques

### ? Inconvénients du stockage Base64

1. **Taille de la base de données**
   - Une image de 500KB devient ~670KB en Base64 (+33%)
   - Peut ralentir les requêtes SQL

2. **Performance**
   - Temps de conversion
   - Transfert de données plus lent

3. **Sauvegarde**
   - Backups de la BD plus volumineux

### ? Bonnes pratiques

1. **Optimiser les images AVANT conversion**
   ```csharp
   // Redimensionner à 800x800 max
   // Compresser en JPEG avec qualité 80%
   ```

2. **Limiter la taille des fichiers**
   ```csharp
   if (new FileInfo(cheminImage).Length > 2_000_000) // 2MB
   {
       throw new Exception("L'image ne doit pas dépasser 2MB");
   }
   ```

3. **Utiliser un index sur la colonne actif**
   ```sql
   CREATE INDEX idx_produits_actif ON produits(actif);
   ```

---

## ?? Alternative : Stockage fichiers + chemin en BD

Si vous préférez stocker les **fichiers images** au lieu du Base64 :

### Modifier la méthode

```csharp
public async Task<int> AjouterProduitAvecFichierAsync(
    string libelle,
    string description,
    decimal prixHT,
    decimal tva,
    int stock,
    string categorie,
    string cheminImageSource)
{
    // Copier l'image vers le dossier public
    string nomFichier = $"{Guid.NewGuid()}.jpg";
    string cheminDestination = $@"C:\xampp\htdocs\epreuve_e6_legere\public\storage\produits\{nomFichier}";
    
    File.Copy(cheminImageSource, cheminDestination, true);

    // Stocker seulement le nom du fichier en BD
    using var connection = new MySqlConnection(_connectionString);
    await connection.OpenAsync();

    const string query = @"
        INSERT INTO produits 
        (libelle, description, prix_ht, tva, stock, categorie, image, created_at, updated_at)
        VALUES 
        (@Libelle, @Description, @PrixHT, @TVA, @Stock, @Categorie, @Image, @CreatedAt, @UpdatedAt)";

    using var command = new MySqlCommand(query, connection);
    command.Parameters.AddWithValue("@Libelle", libelle);
    command.Parameters.AddWithValue("@Description", description);
    command.Parameters.AddWithValue("@PrixHT", prixHT);
    command.Parameters.AddWithValue("@TVA", tva);
    command.Parameters.AddWithValue("@Stock", stock);
    command.Parameters.AddWithValue("@Categorie", categorie);
    command.Parameters.AddWithValue("@Image", nomFichier); // ? Juste le nom
    command.Parameters.AddWithValue("@CreatedAt", DateTime.Now);
    command.Parameters.AddWithValue("@UpdatedAt", DateTime.Now);

    await command.ExecuteNonQueryAsync();
    
    command.CommandText = "SELECT LAST_INSERT_ID()";
    return Convert.ToInt32(await command.ExecuteScalarAsync());
}
```

---

## ?? Tests

### Test unitaire

```csharp
[Fact]
public async Task AjouterProduit_AvecImage_ReussitAsync()
{
    // Arrange
    var service = new ProduitImageService("Server=localhost;...");
    
    // Act
    int id = await service.AjouterProduitAsync(
        "Test Produit",
        "Description test",
        10.50m,
        20m,
        50,
        "Test",
        @"C:\Images\test.jpg"
    );
    
    // Assert
    Assert.True(id > 0);
}
```

---

## ?? Résumé

| Aspect | Valeur |
|--------|--------|
| **Format** | Base64 avec préfixe `data:image/...;base64,` |
| **Stockage** | Colonne `LONGTEXT` dans MariaDB |
| **Conversion** | Automatique via `Convert.ToBase64String()` |
| **Sécurité** | Paramètres SQL préparés |
| **Performance** | ~33% plus lourd que l'image originale |
| **Compatibilité** | Direct dans Laravel (pas de traitement) |

---

## ?? Choix recommandé

Pour un site E-Commerce :
- **< 100 produits** : Base64 acceptable
- **> 100 produits** : Préférer le stockage fichier + chemin en BD

**Avantage Base64** : Plus simple, pas de gestion de dossiers  
**Avantage Fichiers** : Meilleure performance, BD plus légère

Votre code actuel utilise **Base64** - c'est parfait pour démarrer ! ??
