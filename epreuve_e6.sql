-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 03 déc. 2025 à 08:59
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `epreuve_e6`
--
CREATE DATABASE IF NOT EXISTS `epreuve_e6` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `epreuve_e6`;

-- --------------------------------------------------------

--
-- Structure de la table `abilities`
--

DROP TABLE IF EXISTS `abilities`;
CREATE TABLE IF NOT EXISTS `abilities` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_id` bigint UNSIGNED DEFAULT NULL,
  `entity_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `only_owned` tinyint(1) NOT NULL DEFAULT '0',
  `options` json DEFAULT NULL,
  `scope` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `abilities_scope_index` (`scope`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `abilities`
--

INSERT INTO `abilities` (`id`, `name`, `title`, `entity_id`, `entity_type`, `only_owned`, `options`, `scope`, `created_at`, `updated_at`) VALUES
(1, 'manage-products', 'Manage products', NULL, NULL, 0, NULL, NULL, '2025-11-28 10:01:47', '2025-11-28 10:01:47'),
(2, 'manage-orders', 'Manage orders', NULL, NULL, 0, NULL, NULL, '2025-11-28 10:01:47', '2025-11-28 10:01:47'),
(3, 'access-dashboard', 'Access dashboard', NULL, NULL, 0, NULL, NULL, '2025-11-28 10:01:47', '2025-11-28 10:01:47');

-- --------------------------------------------------------

--
-- Structure de la table `assigned_roles`
--

DROP TABLE IF EXISTS `assigned_roles`;
CREATE TABLE IF NOT EXISTS `assigned_roles` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` bigint UNSIGNED NOT NULL,
  `entity_id` bigint UNSIGNED NOT NULL,
  `entity_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `restricted_to_id` bigint UNSIGNED DEFAULT NULL,
  `restricted_to_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scope` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assigned_roles_entity_index` (`entity_id`,`entity_type`,`scope`),
  KEY `assigned_roles_role_id_index` (`role_id`),
  KEY `assigned_roles_scope_index` (`scope`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `assigned_roles`
--

INSERT INTO `assigned_roles` (`id`, `role_id`, `entity_id`, `entity_type`, `restricted_to_id`, `restricted_to_type`, `scope`) VALUES
(1, 1, 1, 'App\\Models\\User', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('epreuve-e6-cache-77de68daecd823babbb58edb1c8e14d7106e83bb:timer', 'i:1764335370;', 1764335370),
('epreuve-e6-cache-77de68daecd823babbb58edb1c8e14d7106e83bb', 'i:1;', 1764335370);

-- --------------------------------------------------------

--
-- Structure de la table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clients_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id`, `nom`, `prenom`, `email`, `telephone`, `created_at`, `updated_at`) VALUES
(1, 'Martin', 'Sophie', 'sophie.martin@example.com', '0612345678', '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(2, 'Durand', 'Pierre', 'pierre.durand@example.com', '0698765432', '2025-11-28 10:01:48', '2025-11-28 10:01:48');

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

DROP TABLE IF EXISTS `commandes`;
CREATE TABLE IF NOT EXISTS `commandes` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` bigint UNSIGNED DEFAULT NULL,
  `numero_commande` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `statut` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'A_PREPARER',
  `creneau_retrait` datetime NOT NULL,
  `total_ht` decimal(10,2) NOT NULL,
  `total_ttc` decimal(10,2) NOT NULL,
  `note_interne` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `commandes_numero_commande_unique` (`numero_commande`),
  KEY `commandes_client_id_foreign` (`client_id`),
  KEY `commandes_statut_index` (`statut`),
  KEY `commandes_creneau_retrait_index` (`creneau_retrait`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `lignes_commandes`
--

DROP TABLE IF EXISTS `lignes_commandes`;
CREATE TABLE IF NOT EXISTS `lignes_commandes` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `commande_id` bigint UNSIGNED NOT NULL,
  `produit_id` bigint UNSIGNED NOT NULL,
  `quantite_demandee` int NOT NULL,
  `quantite_preparee` int NOT NULL DEFAULT '0',
  `prix_unitaire_ht` decimal(10,2) NOT NULL,
  `statut_ligne` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'A_VALIDER',
  `note` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `lignes_commandes_commande_id_foreign` (`commande_id`),
  KEY `lignes_commandes_produit_id_foreign` (`produit_id`),
  KEY `lignes_commandes_statut_ligne_index` (`statut_ligne`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `lignes_tickets`
--

DROP TABLE IF EXISTS `lignes_tickets`;
CREATE TABLE IF NOT EXISTS `lignes_tickets` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint UNSIGNED NOT NULL,
  `produit_id` bigint UNSIGNED NOT NULL,
  `qte` int NOT NULL,
  `prix_unitaire_ht` decimal(8,2) NOT NULL,
  `tva` decimal(4,2) NOT NULL,
  `total_ht` decimal(10,2) NOT NULL,
  `total_ttc` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lignes_tickets_ticket_id_foreign` (`ticket_id`),
  KEY `lignes_tickets_produit_id_foreign` (`produit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_11_14_104153_create_clients_table', 1),
(5, '2025_11_14_104155_create_produits_table', 1),
(6, '2025_11_14_104155_create_tickets_table', 1),
(7, '2025_11_14_104156_create_lignes_tickets_table', 1),
(8, '2025_11_28_000001_add_user_relations_and_fields', 1),
(9, '2025_11_28_090228_create_bouncer_tables', 1),
(10, '2025_11_30_000001_create_commandes_table', 2),
(11, '2025_11_30_000002_create_lignes_commandes_table', 2),
(12, '2025_11_30_000003_create_preparations_table', 2);

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `ability_id` bigint UNSIGNED NOT NULL,
  `entity_id` bigint UNSIGNED DEFAULT NULL,
  `entity_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `forbidden` tinyint(1) NOT NULL DEFAULT '0',
  `scope` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_entity_index` (`entity_id`,`entity_type`,`scope`),
  KEY `permissions_ability_id_index` (`ability_id`),
  KEY `permissions_scope_index` (`scope`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `permissions`
--

INSERT INTO `permissions` (`id`, `ability_id`, `entity_id`, `entity_type`, `forbidden`, `scope`) VALUES
(1, 1, 1, 'roles', 0, NULL),
(2, 2, 1, 'roles', 0, NULL),
(3, 3, 1, 'roles', 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `preparations`
--

DROP TABLE IF EXISTS `preparations`;
CREATE TABLE IF NOT EXISTS `preparations` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `commande_id` bigint UNSIGNED NOT NULL,
  `employe_id` bigint UNSIGNED NOT NULL,
  `statut` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EN_COURS',
  `date_debut` datetime NOT NULL,
  `date_fin` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `preparations_commande_id_foreign` (`commande_id`),
  KEY `preparations_employe_id_foreign` (`employe_id`),
  KEY `preparations_statut_index` (`statut`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

DROP TABLE IF EXISTS `produits`;
CREATE TABLE IF NOT EXISTS `produits` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `reference` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `libelle` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categorie` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prix_ht` decimal(8,2) NOT NULL,
  `tva` decimal(4,2) NOT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `actif` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `produits_reference_unique` (`reference`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id`, `reference`, `libelle`, `description`, `image`, `categorie`, `prix_ht`, `tva`, `stock`, `actif`, `created_at`, `updated_at`) VALUES
(1, 'FRL001', 'Pommes Bio', 'Pommes biologiques de nos producteurs locaux. Variété Golden, parfaites pour les tartes ou à croquer.', NULL, 'Fruits & Légumes', 3.99, 5.50, 150, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(2, 'FRL002', 'Tomates en Grappe', 'Tomates fraîches en grappe, cultivées en France. Idéales pour les salades.', NULL, 'Fruits & Légumes', 2.99, 5.50, 80, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(3, 'FRL003', 'Bananes', 'Bananes Cavendish, origine Amérique Latine.', NULL, 'Fruits & Légumes', 1.89, 5.50, 5, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(4, 'BOU001', 'Baguette Tradition', 'Baguette tradition française cuite au four, croustillante à souhait.', NULL, 'Boulangerie', 1.05, 5.50, 150, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(5, 'BOU002', 'Pain Complet', 'Pain complet aux céréales, riche en fibres.', NULL, 'Boulangerie', 2.50, 5.50, 45, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(6, 'CRE001', 'Lait Bio 1L', 'Lait entier biologique, origine France.', NULL, 'Crémerie', 1.45, 5.50, 90, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(7, 'CRE002', 'Yaourts Nature x8', 'Yaourts nature au lait entier, pack de 8.', NULL, 'Crémerie', 3.20, 5.50, 60, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(8, 'CRE003', 'Beurre Doux 250g', 'Beurre doux, 82% de matière grasse.', NULL, 'Crémerie', 2.80, 5.50, 0, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(9, 'EPI001', 'Pâtes Complètes 1kg', 'Pâtes complètes italiennes, temps de cuisson 11 min.', NULL, 'Épicerie', 1.80, 5.50, 150, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(10, 'EPI002', 'Riz Basmati 1kg', 'Riz basmati long grain, origine Inde.', NULL, 'Épicerie', 3.50, 5.50, 100, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(11, 'EPI003', 'Huile d\'Olive 75cl', 'Huile d\'olive vierge extra, première pression à froid.', NULL, 'Épicerie', 6.90, 20.00, 50, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(12, 'BOI001', 'Jus d\'Orange 1L', 'Jus d\'orange 100% pur jus, sans sucres ajoutés.', NULL, 'Boissons', 2.10, 5.50, 80, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(13, 'BOI002', 'Eau Minérale 6x1.5L', 'Pack de 6 bouteilles d\'eau minérale naturelle.', NULL, 'Boissons', 3.50, 5.50, 120, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(14, 'VIA001', 'Poulet Fermier', 'Poulet fermier Label Rouge, élevé en plein air.', NULL, 'Viandes & Poissons', 8.90, 5.50, 25, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(15, 'VIA002', 'Saumon Fumé 200g', 'Saumon fumé d\'Écosse, tranché finement.', NULL, 'Viandes & Poissons', 7.50, 5.50, 30, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(16, 'SUR001', 'Pizza Margherita', 'Pizza surgelée margherita, 400g.', NULL, 'Surgelés', 3.99, 5.50, 70, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(17, 'FRL004', 'Fraises Gariguette', 'Fraises Gariguette de France (rupture temporaire).', NULL, 'Fruits & Légumes', 4.50, 5.50, 120, 1, '2025-11-28 10:01:48', '2025-11-28 10:01:48');

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scope` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`,`scope`),
  KEY `roles_scope_index` (`scope`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `roles`
--

INSERT INTO `roles` (`id`, `name`, `title`, `scope`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Admin', NULL, '2025-11-28 10:01:47', '2025-11-28 10:01:47');

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('FSLmN9Jywn1E7ailgMJZIv8bqw7ROIbg0iz8eTMx', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Herd/1.24.0 Chrome/120.0.6099.291 Electron/28.2.5 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia1Awd1VCWWRDQWVWcnp3V0JiRFVicVJ0MWhKZmM2cnkxRkVRVEF4RiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDQ6Imh0dHBzOi8vZXByZXV2ZV9lNl9sZWdlcmUudGVzdC8/aGVyZD1wcmV2aWV3IjtzOjU6InJvdXRlIjtzOjc6ImFjY3VlaWwiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1764448850),
('Uw9ouL9dkwnH7tf3exkwB3qVRoxU3WlP02eR0EXz', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 OPR/124.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMXBUbFpvUVJleE9Lc0NNQzV0b3N1ajRFeld0ZXNXcm9mSUpsWHBRbSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHBzOi8vZXByZXV2ZV9lNl9sZWdlcmUudGVzdC9wYW5pZXIiO3M6NToicm91dGUiO3M6MTI6InBhbmllci5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NjoicGFuaWVyIjthOjE6e2k6MzthOjc6e3M6MTA6InByb2R1aXRfaWQiO2k6MztzOjc6ImxpYmVsbGUiO3M6NzoiQmFuYW5lcyI7czo3OiJwcml4X2h0IjtzOjQ6IjEuODkiO3M6MzoidHZhIjtzOjQ6IjUuNTAiO3M6ODoicHJpeF90dGMiO2Q6MS45OTM5NTtzOjg6InF1YW50aXRlIjtpOjE7czo1OiJpbWFnZSI7Tjt9fX0=', 1764449155),
('w8c1GaeaFHmaI5ZUYDBo7rvYYAILCFH2VlfoYeuq', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Herd/1.24.0 Chrome/120.0.6099.291 Electron/28.2.5 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZEhjSmxhSGZSMjhDb0t2N29xa0dObk5qV3piUU51ZGZlVlJQZnVlUiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDQ6Imh0dHBzOi8vZXByZXV2ZV9lNl9sZWdlcmUudGVzdC8/aGVyZD1wcmV2aWV3IjtzOjU6InJvdXRlIjtzOjc6ImFjY3VlaWwiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1764536139),
('kWwhZGFm8TyAt9KNGDho8NDEQzZn0Q8WU5DyZSHZ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 OPR/124.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidnN0dDNPSE5FYjFYc3hPUlFIUlBoNGpUa3I5Y1EwOE5oNEpzTmZXWCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHBzOi8vZXByZXV2ZV9lNl9sZWdlcmUudGVzdC9wYW5pZXIiO3M6NToicm91dGUiO3M6MTI6InBhbmllci5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NjoicGFuaWVyIjthOjE6e2k6MzthOjc6e3M6MTA6InByb2R1aXRfaWQiO2k6MztzOjc6ImxpYmVsbGUiO3M6NzoiQmFuYW5lcyI7czo3OiJwcml4X2h0IjtzOjQ6IjEuODkiO3M6MzoidHZhIjtzOjQ6IjUuNTAiO3M6ODoicHJpeF90dGMiO2Q6MS45OTM5NTtzOjg6InF1YW50aXRlIjtpOjE7czo1OiJpbWFnZSI7Tjt9fX0=', 1764536169),
('rmukYApXwevin5g8tBXJKsArk9KVFLi1iSuiqeDZ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Herd/1.24.0 Chrome/120.0.6099.291 Electron/28.2.5 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZmRtMm90ekxiRlR5NFFMSnNiS3VxeEUxaEY4dDNoQUJ1VGRVQ3QzdyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDQ6Imh0dHBzOi8vZXByZXV2ZV9lNl9sZWdlcmUudGVzdC8/aGVyZD1wcmV2aWV3IjtzOjU6InJvdXRlIjtzOjc6ImFjY3VlaWwiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1764577360),
('iMqIgJy1qEZYTiylLy8biyqe72U7zng6J6pbG0D9', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 OPR/124.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNFpCYXVwNnVLOFhtcXB4VFBEWjJ2RGY4OWZLTGxQVmh4d2NTTFBQUiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHBzOi8vZXByZXV2ZV9lNl9sZWdlcmUudGVzdC9wYW5pZXIiO3M6NToicm91dGUiO3M6MTI6InBhbmllci5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MzoidXJsIjthOjE6e3M6ODoiaW50ZW5kZWQiO3M6NDA6Imh0dHBzOi8vZXByZXV2ZV9lNl9sZWdlcmUudGVzdC9kYXNoYm9hcmQiO319', 1764577398),
('wJ6edL8JxfRk3FE8N7DPmT28KcIGGyvbXeDnZGLL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Herd/1.24.0 Chrome/120.0.6099.291 Electron/28.2.5 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMk52WXFHRE96dFg1WHBGUUJNRkJwZVlsZWxMTW1ZTldsVkdkQkhVTiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDQ6Imh0dHBzOi8vZXByZXV2ZV9lNl9sZWdlcmUudGVzdC8/aGVyZD1wcmV2aWV3IjtzOjU6InJvdXRlIjtzOjc6ImFjY3VlaWwiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1764577367);

-- --------------------------------------------------------

--
-- Structure de la table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
CREATE TABLE IF NOT EXISTS `tickets` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `total_ht` decimal(10,2) NOT NULL,
  `total_tva` decimal(10,2) NOT NULL,
  `total_ttc` decimal(10,2) NOT NULL,
  `moyen_paiement` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `statut` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'VALIDE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tickets_client_id_foreign` (`client_id`),
  KEY `tickets_user_id_foreign` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `is_admin`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Administrateur', 'admin@drive.test', NULL, '$2y$12$B8hfk8jebb7L8Q7cqjNyau060IsAXTxHLpGgOSLMEkoc7M6l3odM.', 1, NULL, '2025-11-28 10:01:47', '2025-11-28 10:01:47'),
(2, 'Jean Dupont', 'user@drive.test', NULL, '$2y$12$HgSyfsncPqVokE4QJQioPOAsijdwxtOu8K0NeCRu0l/ZTbmA85Jqy', 0, NULL, '2025-11-28 10:01:48', '2025-11-28 10:01:48'),
(3, 'Noan', 'noanbregeon@gmail.com', '2025-11-28 12:06:01', '$2y$12$HznUCRguyo5L7fXU0Zex5OPIernJGdaDdOaZKgqWCD4Ou/XEwiGyS', 0, NULL, '2025-11-28 12:05:07', '2025-11-28 12:06:01');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
