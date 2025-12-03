-- Script pour ajouter des images aux produits existants
-- À exécuter APRÈS avoir placé les images dans le dossier

USE epreuve_e6;

-- Mise à jour des images pour les produits
UPDATE produits SET image = 'pommes_bio.jpg', updated_at = NOW() WHERE reference = 'FRL001';
UPDATE produits SET image = 'tomates_grappe.jpg', updated_at = NOW() WHERE reference = 'FRL002';
UPDATE produits SET image = 'bananes.jpg', updated_at = NOW() WHERE reference = 'FRL003';
UPDATE produits SET image = 'baguette_tradition.jpg', updated_at = NOW() WHERE reference = 'BOU001';
UPDATE produits SET image = 'pain_complet.jpg', updated_at = NOW() WHERE reference = 'BOU002';
UPDATE produits SET image = 'lait_bio.jpg', updated_at = NOW() WHERE reference = 'CRE001';
UPDATE produits SET image = 'yaourts_nature.jpg', updated_at = NOW() WHERE reference = 'CRE002';
UPDATE produits SET image = 'beurre_doux.jpg', updated_at = NOW() WHERE reference = 'CRE003';
UPDATE produits SET image = 'pates_completes.jpg', updated_at = NOW() WHERE reference = 'EPI001';
UPDATE produits SET image = 'riz_basmati.jpg', updated_at = NOW() WHERE reference = 'EPI002';
UPDATE produits SET image = 'huile_olive.jpg', updated_at = NOW() WHERE reference = 'EPI003';
UPDATE produits SET image = 'jus_orange.jpg', updated_at = NOW() WHERE reference = 'BOI001';
UPDATE produits SET image = 'eau_minerale.jpg', updated_at = NOW() WHERE reference = 'BOI002';
UPDATE produits SET image = 'poulet_fermier.jpg', updated_at = NOW() WHERE reference = 'VIA001';
UPDATE produits SET image = 'saumon_fume.jpg', updated_at = NOW() WHERE reference = 'VIA002';
UPDATE produits SET image = 'pizza_margherita.jpg', updated_at = NOW() WHERE reference = 'SUR001';
UPDATE produits SET image = 'fraises_gariguette.jpg', updated_at = NOW() WHERE reference = 'FRL004';

-- Vérification
SELECT reference, libelle, image 
FROM produits 
WHERE actif = 1 
ORDER BY categorie, libelle;
