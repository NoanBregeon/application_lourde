# ??? GUIDE - Gestion des Images Produits

## ?? Architecture des dossiers

### Pour le site web Laravel
```
C:\xampp\htdocs\epreuve_e6_legere\
??? public\
?   ??? storage\
?       ??? produits\          ? Dossier des images produits
?           ??? pommes_bio.jpg
?           ??? bananes.jpg
?           ??? tomates_grappe.jpg
?           ??? ...
```

### Pour l'application WPF (application lourde)
L'application WPF accède aux images via le **même dossier** que le site web.

---

## ?? Mise en place - Étapes

### Étape 1 : Créer le dossier des images

```bash
# Si vous utilisez XAMPP
mkdir C:\xampp\htdocs\epreuve_e6_legere\public\storage\produits

# Si vous utilisez Laravel Herd
mkdir C:\Users\[VotreNom]\Herd\epreuve_e6_legere\public\storage\produits
```

### Étape 2 : Créer le lien symbolique dans Laravel

Dans le terminal, depuis le dossier du projet Laravel :

```bash
cd C:\xampp\htdocs\epreuve_e6_legere
php artisan storage:link
```

Cela créera un lien symbolique de `public/storage` vers `storage/app/public`

### Étape 3 : Placer les images de test

Téléchargez des images libres de droits depuis :
- **Unsplash** : https://unsplash.com/
- **Pexels** : https://www.pexels.com/
- **Pixabay** : https://pixabay.com/

Renommez-les selon le tableau ci-dessous et placez-les dans :
`C:\xampp\htdocs\epreuve_e6_legere\public\storage\produits\`

### Étape 4 : Noms des fichiers images

| Référence | Nom du fichier | Produit |
|-----------|----------------|---------|
| FRL001 | `pommes_bio.jpg` | Pommes Bio |
| FRL002 | `tomates_grappe.jpg` | Tomates en Grappe |
| FRL003 | `bananes.jpg` | Bananes |
| BOU001 | `baguette_tradition.jpg` | Baguette Tradition |
| BOU002 | `pain_complet.jpg` | Pain Complet |
| CRE001 | `lait_bio.jpg` | Lait Bio 1L |
| CRE002 | `yaourts_nature.jpg` | Yaourts Nature x8 |
| CRE003 | `beurre_doux.jpg` | Beurre Doux 250g |
| EPI001 | `pates_completes.jpg` | Pâtes Complètes 1kg |
| EPI002 | `riz_basmati.jpg` | Riz Basmati 1kg |
| EPI003 | `huile_olive.jpg` | Huile d'Olive 75cl |
| BOI001 | `jus_orange.jpg` | Jus d'Orange 1L |
| BOI002 | `eau_minerale.jpg` | Eau Minérale 6x1.5L |
| VIA001 | `poulet_fermier.jpg` | Poulet Fermier |
| VIA002 | `saumon_fume.jpg` | Saumon Fumé 200g |
| SUR001 | `pizza_margherita.jpg` | Pizza Margherita |
| FRL004 | `fraises_gariguette.jpg` | Fraises Gariguette |

### Étape 5 : Mettre à jour la base de données

Exécutez le script SQL :

```bash
mysql -u root epreuve_e6 < update_images.sql
```

Ou dans phpMyAdmin :
1. Sélectionnez la base `epreuve_e6`
2. Onglet **SQL**
3. Collez le contenu de `update_images.sql`
4. Cliquez sur **Exécuter**

---

## ?? Utilisation dans l'application WPF

### Dans le XAML (exemple pour une liste de produits)

```xml
<DataGrid ItemsSource="{Binding Produits}">
    <DataGrid.Columns>
        <DataGridTemplateColumn Header="Image" Width="80">
            <DataGridTemplateColumn.CellTemplate>
                <DataTemplate>
                    <Image Source="{Binding CheminImage}" 
                           Width="60" 
                           Height="60" 
                           Stretch="UniformToFill"
                           Margin="5"/>
                </DataTemplate>
            </DataGridTemplateColumn.CellTemplate>
        </DataGridTemplateColumn>
        <DataGridTextColumn Header="Référence" Binding="{Binding Reference}" Width="100"/>
        <DataGridTextColumn Header="Libellé" Binding="{Binding Libelle}" Width="*"/>
        <DataGridTextColumn Header="Prix TTC" Binding="{Binding PrixTTC, StringFormat='{}{0:C2}'}" Width="100"/>
    </DataGrid.Columns>
</DataGrid>
```

### Dans un formulaire de détails

```xml
<StackPanel>
    <Image Source="{Binding ProduitSelectionne.CheminImage}" 
           Width="300" 
           Height="300" 
           Stretch="Uniform"
           HorizontalAlignment="Center"
           Margin="10"/>
    <TextBlock Text="{Binding ProduitSelectionne.Libelle}" 
               FontSize="20" 
               FontWeight="Bold"
               HorizontalAlignment="Center"/>
    <TextBlock Text="{Binding ProduitSelectionne.Description}" 
               TextWrapping="Wrap"
               Margin="10"/>
</StackPanel>
```

---

## ?? Utilisation dans le site web Laravel

### Dans les vues Blade

```php
<!-- Liste de produits -->
@foreach($produits as $produit)
    <div class="produit-card">
        <img src="{{ asset('storage/produits/' . $produit->image) }}" 
             alt="{{ $produit->libelle }}"
             class="produit-image">
        <h3>{{ $produit->libelle }}</h3>
        <p class="prix">{{ number_format($produit->prix_ttc, 2) }} €</p>
    </div>
@endforeach
```

### Dans un contrôleur

```php
public function index()
{
    $produits = Produit::where('actif', 1)
                      ->get()
                      ->map(function($produit) {
                          $produit->url_image = $produit->image 
                              ? asset('storage/produits/' . $produit->image)
                              : null;
                          return $produit;
                      });
    
    return view('produits.index', compact('produits'));
}
```

---

## ?? Ajout d'une nouvelle image (Formulaire dans Laravel)

### Migration pour le stockage

```php
// Le champ 'image' existe déjà dans votre base de données
```

### Contrôleur Laravel

```php
public function store(Request $request)
{
    $validated = $request->validate([
        'reference' => 'required|unique:produits',
        'libelle' => 'required',
        'prix_ht' => 'required|numeric',
        'tva' => 'required|numeric',
        'image' => 'nullable|image|max:2048' // 2MB max
    ]);

    if ($request->hasFile('image')) {
        $imageName = $validated['reference'] . '.' . $request->image->extension();
        $request->image->move(public_path('storage/produits'), $imageName);
        $validated['image'] = $imageName;
    }

    Produit::create($validated);

    return redirect()->route('produits.index')
                     ->with('success', 'Produit créé avec succès');
}
```

### Formulaire Blade

```html
<form action="{{ route('produits.store') }}" method="POST" enctype="multipart/form-data">
    @csrf
    
    <div class="form-group">
        <label for="libelle">Libellé</label>
        <input type="text" name="libelle" class="form-control" required>
    </div>

    <div class="form-group">
        <label for="reference">Référence</label>
        <input type="text" name="reference" class="form-control" required>
    </div>

    <div class="form-group">
        <label for="prix_ht">Prix HT</label>
        <input type="number" step="0.01" name="prix_ht" class="form-control" required>
    </div>

    <div class="form-group">
        <label for="image">Image du produit</label>
        <input type="file" name="image" class="form-control" accept="image/*">
    </div>

    <button type="submit" class="btn btn-primary">Créer</button>
</form>
```

---

## ? Vérification

### Test dans l'application WPF
1. Lancez l'application WPF (F5)
2. Allez dans **Stock**
3. Les images devraient s'afficher à côté de chaque produit

### Test dans le site web
1. Allez sur `https://epreuve_e6_legere.test/produits`
2. Les images devraient s'afficher dans la liste des produits

---

## ?? Configuration du chemin dans appsettings.json (optionnel)

Si vous voulez configurer le chemin des images :

```json
{
  "ConnectionStrings": {
    "MariaDb": "Server=localhost;Port=3306;Database=epreuve_e6;User=root;Password=;"
  },
  "ImageSettings": {
    "BasePath": "C:\\xampp\\htdocs\\epreuve_e6_legere\\public\\storage\\produits",
    "WebBasePath": "/storage/produits"
  }
}
```

---

## ?? Bonnes pratiques

1. **Nommage** : Utilisez la référence du produit comme nom de fichier
2. **Format** : JPG pour les photos, PNG pour les images avec transparence
3. **Taille** : Optimisez les images (max 500KB par image)
4. **Dimensions** : 800x800 pixels recommandé
5. **Sauvegarde** : Incluez le dossier `storage/produits` dans vos sauvegardes

---

## ?? Dépannage

### Les images ne s'affichent pas dans WPF
- Vérifiez que le chemin dans `CheminImage` est correct
- Vérifiez que les fichiers existent dans le dossier
- Vérifiez les permissions du dossier

### Les images ne s'affichent pas sur le site web
- Exécutez `php artisan storage:link`
- Vérifiez que les fichiers sont dans `public/storage/produits`
- Vérifiez les permissions du dossier (chmod 755)

### Erreur 404 sur les images
- Le lien symbolique n'est pas créé : `php artisan storage:link`
- Les fichiers sont dans le mauvais dossier

---

## ?? Résumé

- **Un seul dossier** pour les images : `public/storage/produits`
- **Accessible** par le site web ET l'application WPF
- **Base de données** : stocke uniquement le nom du fichier
- **Application WPF** : utilise `CheminImage` pour l'affichage
- **Site web** : utilise `asset('storage/produits/' . $image)`

**Les deux applications partagent les mêmes images !** ??
