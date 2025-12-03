-- Script de données de test pour l'application WPF
-- Compatible avec la structure existante de epreuve_e6

USE epreuve_e6;

-- =============================================
-- INSERTION DE DONNÉES DE TEST POUR COMMANDES
-- =============================================

-- Insertion de commandes de test
INSERT INTO commandes (client_id, numero_commande, statut, creneau_retrait, total_ht, total_ttc, note_interne, created_at, updated_at) VALUES
(1, 'CMD-2024-001', 'A_PREPARER', DATE_ADD(NOW(), INTERVAL 2 HOUR), 15.50, 16.35, 'Commande urgente', NOW(), NOW()),
(2, 'CMD-2024-002', 'EN_PREPARATION', DATE_ADD(NOW(), INTERVAL 3 HOUR), 25.80, 27.20, NULL, NOW(), NOW()),
(1, 'CMD-2024-003', 'A_PREPARER', DATE_ADD(NOW(), INTERVAL 4 HOUR), 12.30, 12.98, NULL, NOW(), NOW()),
(2, 'CMD-2024-004', 'PRETE', DATE_ADD(NOW(), INTERVAL -1 HOUR), 45.60, 48.09, 'Commande retirée', NOW(), NOW()),
(1, 'CMD-2024-005', 'PRETE', DATE_ADD(NOW(), INTERVAL -2 HOUR), 32.10, 33.86, NULL, NOW(), NOW())
ON DUPLICATE KEY UPDATE statut=VALUES(statut);

-- Récupérer les IDs des commandes créées
SET @cmd1 = (SELECT id FROM commandes WHERE numero_commande = 'CMD-2024-001');
SET @cmd2 = (SELECT id FROM commandes WHERE numero_commande = 'CMD-2024-002');
SET @cmd3 = (SELECT id FROM commandes WHERE numero_commande = 'CMD-2024-003');
SET @cmd4 = (SELECT id FROM commandes WHERE numero_commande = 'CMD-2024-004');
SET @cmd5 = (SELECT id FROM commandes WHERE numero_commande = 'CMD-2024-005');

-- =============================================
-- INSERTION DES LIGNES DE COMMANDES
-- =============================================

-- Commande 1 (CMD-2024-001 - A_PREPARER)
INSERT INTO lignes_commandes (commande_id, produit_id, quantite_demandee, quantite_preparee, prix_unitaire_ht, statut_ligne, note) VALUES
(@cmd1, 1, 5, 0, 3.99, 'A_VALIDER', NULL),
(@cmd1, 6, 2, 0, 1.45, 'A_VALIDER', NULL),
(@cmd1, 4, 3, 0, 1.05, 'A_VALIDER', NULL)
ON DUPLICATE KEY UPDATE statut_ligne=VALUES(statut_ligne);

-- Commande 2 (CMD-2024-002 - EN_PREPARATION)
INSERT INTO lignes_commandes (commande_id, produit_id, quantite_demandee, quantite_preparee, prix_unitaire_ht, statut_ligne, note) VALUES
(@cmd2, 2, 4, 4, 2.99, 'VALIDEE', NULL),
(@cmd2, 7, 2, 0, 3.20, 'A_VALIDER', NULL),
(@cmd2, 13, 1, 0, 3.50, 'A_VALIDER', NULL)
ON DUPLICATE KEY UPDATE statut_ligne=VALUES(statut_ligne);

-- Commande 3 (CMD-2024-003 - A_PREPARER)
INSERT INTO lignes_commandes (commande_id, produit_id, quantite_demandee, quantite_preparee, prix_unitaire_ht, statut_ligne, note) VALUES
(@cmd3, 3, 3, 0, 1.89, 'A_VALIDER', 'Stock faible'),
(@cmd3, 8, 2, 0, 2.80, 'RUPTURE', 'Produit en rupture de stock'),
(@cmd3, 5, 1, 0, 2.50, 'A_VALIDER', NULL)
ON DUPLICATE KEY UPDATE statut_ligne=VALUES(statut_ligne);

-- Commande 4 (CMD-2024-004 - PRETE - Historique)
INSERT INTO lignes_commandes (commande_id, produit_id, quantite_demandee, quantite_preparee, prix_unitaire_ht, statut_ligne, note) VALUES
(@cmd4, 9, 3, 3, 1.80, 'VALIDEE', NULL),
(@cmd4, 10, 2, 2, 3.50, 'VALIDEE', NULL),
(@cmd4, 14, 1, 1, 8.90, 'VALIDEE', NULL)
ON DUPLICATE KEY UPDATE statut_ligne=VALUES(statut_ligne);

-- Commande 5 (CMD-2024-005 - PRETE - Historique)
INSERT INTO lignes_commandes (commande_id, produit_id, quantite_demandee, quantite_preparee, prix_unitaire_ht, statut_ligne, note) VALUES
(@cmd5, 15, 2, 2, 7.50, 'VALIDEE', NULL),
(@cmd5, 12, 3, 3, 2.10, 'VALIDEE', NULL)
ON DUPLICATE KEY UPDATE statut_ligne=VALUES(statut_ligne);

-- =============================================
-- MISE À JOUR DES TOTAUX
-- =============================================

UPDATE commandes c
SET total_ht = (
    SELECT COALESCE(SUM(lc.quantite_demandee * lc.prix_unitaire_ht), 0)
    FROM lignes_commandes lc
    WHERE lc.commande_id = c.id
),
total_ttc = (
    SELECT COALESCE(SUM(lc.quantite_demandee * lc.prix_unitaire_ht * (1 + p.tva / 100)), 0)
    FROM lignes_commandes lc
    JOIN produits p ON lc.produit_id = p.id
    WHERE lc.commande_id = c.id
),
updated_at = NOW();

-- =============================================
-- VÉRIFICATION
-- =============================================

SELECT '=== RÉSUMÉ DES DONNÉES ===' as ''
SELECT CONCAT('Nombre de clients: ', COUNT(*)) as Info FROM clients;
SELECT CONCAT('Nombre de produits: ', COUNT(*)) as Info FROM produits;
SELECT CONCAT('Nombre de commandes: ', COUNT(*)) as Info FROM commandes;
SELECT CONCAT('Nombre de lignes de commande: ', COUNT(*)) as Info FROM lignes_commandes;

SELECT '=== PRODUITS EN STOCK FAIBLE ===' as ''
SELECT reference, libelle, stock FROM produits WHERE stock < 5 AND actif = 1;

SELECT '=== COMMANDES À PRÉPARER ===' as ''
SELECT numero_commande, statut, creneau_retrait, total_ttc 
FROM commandes 
WHERE statut IN ('A_PREPARER', 'EN_PREPARATION')
ORDER BY creneau_retrait;

SELECT '=== LIGNES EN RUPTURE ===' as ''
SELECT c.numero_commande, p.libelle, lc.statut_ligne, lc.note
FROM lignes_commandes lc
JOIN commandes c ON lc.commande_id = c.id
JOIN produits p ON lc.produit_id = p.id
WHERE lc.statut_ligne = 'RUPTURE';

SELECT 'Données de test insérées avec succès !' as 'STATUS';
