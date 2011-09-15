-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Jeu 25 Mars 2010 à 09:24
-- Version du serveur: 5.1.37
-- Version de PHP: 5.2.11

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Base de données: `montlevic`
--

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upcategory_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Contenu de la table `categories`
--

INSERT INTO `categories` VALUES(1, 2, 'fongicide', '2008-04-16 11:13:07', '2009-06-14 20:08:47');
INSERT INTO `categories` VALUES(2, 2, 'herbicide', '2008-04-16 11:13:29', '2009-06-14 20:11:31');
INSERT INTO `categories` VALUES(3, 2, 'glyphosate', '2008-04-16 11:13:38', '2009-06-14 20:12:19');
INSERT INTO `categories` VALUES(4, 1, 'agri', '2009-06-14 20:14:24', '2010-01-28 10:53:00');
INSERT INTO `categories` VALUES(5, 1, 'maison', '2010-01-27 16:40:03', '2010-01-28 10:53:10');
INSERT INTO `categories` VALUES(6, 3, 'cover', '2010-01-27 16:40:59', '2010-01-27 16:40:59');
INSERT INTO `categories` VALUES(7, 1, 'invest', '2010-01-28 10:53:30', '2010-01-28 10:53:30');
INSERT INTO `categories` VALUES(8, 3, 'vib', '2010-01-28 10:53:47', '2010-01-28 10:53:47');
INSERT INTO `categories` VALUES(9, 2, 'test', '2010-02-04 16:14:02', '2010-03-19 19:04:57');

-- --------------------------------------------------------

--
-- Structure de la table `charges`
--

CREATE TABLE `charges` (
  `toto` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `charges`
--


-- --------------------------------------------------------

--
-- Structure de la table `factoparcelles`
--

CREATE TABLE `factoparcelles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parcelle_id` int(11) DEFAULT NULL,
  `facture_id` int(11) DEFAULT NULL,
  `value` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- Contenu de la table `factoparcelles`
--

INSERT INTO `factoparcelles` VALUES(26, 8, 20, 1, '2010-03-23 23:12:46', '2010-03-23 23:12:46');
INSERT INTO `factoparcelles` VALUES(27, 9, 20, 1, '2010-03-23 23:12:46', '2010-03-23 23:12:46');
INSERT INTO `factoparcelles` VALUES(28, 10, 20, 1, '2010-03-23 23:12:46', '2010-03-23 23:12:46');

-- --------------------------------------------------------

--
-- Structure de la table `factures`
--

CREATE TABLE `factures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `factype_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `cout` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

--
-- Contenu de la table `factures`
--

INSERT INTO `factures` VALUES(18, 4, 3, NULL, 1, 'f-1', 300, '2010-03-22 19:55:43', '2010-03-24 08:07:07');
INSERT INTO `factures` VALUES(20, 4, 3, NULL, 1, 'f-2', 300, '2010-03-23 23:12:46', '2010-03-24 08:07:26');

-- --------------------------------------------------------

--
-- Structure de la table `factypes`
--

CREATE TABLE `factypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `desc` text NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `factypes`
--

INSERT INTO `factypes` VALUES(1, 'diff', 'Les charges associ�es a cette facture sont affect�es a chaques depenses (pulv�s et labours).\r\nLa somme de toutes les charges associ�es a la facture est d�duit du cout de la facture et le reste (cout_facture - somme_des_charges) est r�parti sur les parcelles associ�es a la facture.', '2010-01-28 11:16:51', '2010-01-29 17:44:26');
INSERT INTO `factypes` VALUES(3, 'cout total', 'Les charges associ�es a cette facture ne sont pas d�duites du cout de la facture.\r\n\r\nil s''agit simplement de liens virtuels qui permettent d''associer des charges a des facture pour tracer facilement les depenses.\r\n\r\nLe cout de la facture est r�parti entre sur les parcelles associ�es (avec prise en compte du taux associ�.', '2010-01-28 11:51:09', '2010-01-29 18:03:04');

-- --------------------------------------------------------

--
-- Structure de la table `labours`
--

CREATE TABLE `labours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `dosage` int(11) DEFAULT NULL,
  `prix_littre` int(11) DEFAULT NULL,
  `cout_ha_passage` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Contenu de la table `labours`
--

INSERT INTO `labours` VALUES(14, 6, 1, NULL, 'labour-1', NULL, NULL, 10, '2010-03-22 19:59:18', '2010-03-22 19:59:18');
INSERT INTO `labours` VALUES(15, 6, 1, NULL, 'test', NULL, NULL, 10, '2010-03-23 23:05:09', '2010-03-23 23:05:09');
INSERT INTO `labours` VALUES(16, 6, 1, '2010-03-31', 'test date', NULL, NULL, 1, '2010-03-24 17:21:18', '2010-03-24 17:21:18');

-- --------------------------------------------------------

--
-- Structure de la table `labtofactures`
--

CREATE TABLE `labtofactures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facture_id` int(11) DEFAULT NULL,
  `labour_id` int(11) DEFAULT NULL,
  `value` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `labtofactures`
--


-- --------------------------------------------------------

--
-- Structure de la table `labtoparcelles`
--

CREATE TABLE `labtoparcelles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parcelle_id` int(11) DEFAULT NULL,
  `labour_id` int(11) DEFAULT NULL,
  `value` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=67 ;

--
-- Contenu de la table `labtoparcelles`
--

INSERT INTO `labtoparcelles` VALUES(64, 9, 14, 100, '2010-03-23 23:04:26', '2010-03-23 23:04:53');
INSERT INTO `labtoparcelles` VALUES(65, 8, 14, 100, '2010-03-23 23:04:53', '2010-03-23 23:04:53');
INSERT INTO `labtoparcelles` VALUES(66, 10, 14, 100, '2010-03-23 23:04:53', '2010-03-23 23:04:53');

-- --------------------------------------------------------

--
-- Structure de la table `parcelles`
--

CREATE TABLE `parcelles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typeculture_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `surface` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Contenu de la table `parcelles`
--

INSERT INTO `parcelles` VALUES(8, 1, 'parcelle 1', 10, '2010-03-18 19:11:51', '2010-03-22 23:20:08');
INSERT INTO `parcelles` VALUES(9, 2, 'parcelle 2', 10, '2010-03-22 20:33:37', '2010-03-22 23:17:28');
INSERT INTO `parcelles` VALUES(10, 3, 'parcelle 3', 10, '2010-03-23 21:20:25', '2010-03-23 22:04:39');

-- --------------------------------------------------------

--
-- Structure de la table `pulves`
--

CREATE TABLE `pulves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `dosage` float DEFAULT NULL,
  `prix_littre` float DEFAULT NULL,
  `cout_ha_passage` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Contenu de la table `pulves`
--

INSERT INTO `pulves` VALUES(7, 1, 1, NULL, 'p1', 1, 1, 10, '2010-03-24 08:21:47', '2010-03-24 08:21:47');

-- --------------------------------------------------------

--
-- Structure de la table `putofactures`
--

CREATE TABLE `putofactures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facture_id` int(11) DEFAULT NULL,
  `pulve_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `putofactures`
--


-- --------------------------------------------------------

--
-- Structure de la table `putoparcelles`
--

CREATE TABLE `putoparcelles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parcelle_id` int(11) DEFAULT NULL,
  `pulve_id` int(11) DEFAULT NULL,
  `value` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `putoparcelles`
--

INSERT INTO `putoparcelles` VALUES(2, 8, 7, 1, '2010-03-24 08:21:47', '2010-03-24 08:21:47');

-- --------------------------------------------------------

--
-- Structure de la table `saisons`
--

CREATE TABLE `saisons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `saisons`
--

INSERT INTO `saisons` VALUES(1, '2009');
INSERT INTO `saisons` VALUES(2, '2010');
INSERT INTO `saisons` VALUES(3, '2011');

-- --------------------------------------------------------

--
-- Structure de la table `schema_migrations`
--

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `schema_migrations`
--

INSERT INTO `schema_migrations` VALUES('20080718205616');
INSERT INTO `schema_migrations` VALUES('20080718205908');
INSERT INTO `schema_migrations` VALUES('20080918210237');
INSERT INTO `schema_migrations` VALUES('20081009223323');
INSERT INTO `schema_migrations` VALUES('20081009223404');
INSERT INTO `schema_migrations` VALUES('20090121125841');
INSERT INTO `schema_migrations` VALUES('20090307211956');

-- --------------------------------------------------------

--
-- Structure de la table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `saison_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `settings`
--


-- --------------------------------------------------------

--
-- Structure de la table `typecultures`
--

CREATE TABLE `typecultures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `typecultures`
--

INSERT INTO `typecultures` VALUES(1, 'ble');
INSERT INTO `typecultures` VALUES(2, 'colza');
INSERT INTO `typecultures` VALUES(3, 'herbe');

-- --------------------------------------------------------

--
-- Structure de la table `upcategories`
--

CREATE TABLE `upcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `upcategories`
--

INSERT INTO `upcategories` VALUES(1, 'facture', '2009-06-14 20:08:09', '2009-06-14 20:08:09');
INSERT INTO `upcategories` VALUES(2, 'pulve', '2009-06-14 20:08:09', '2010-01-28 10:52:23');
INSERT INTO `upcategories` VALUES(3, 'labour', '2010-01-27 11:27:12', '2010-01-27 11:27:38');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `users`
--

INSERT INTO `users` VALUES(1, 'jouve', '2008-04-16 11:13:07', '2008-04-16 11:13:07');
INSERT INTO `users` VALUES(2, 'trochet', '2008-04-16 11:13:29', '2008-04-16 11:13:29');
INSERT INTO `users` VALUES(3, 'bibi', '2008-04-16 11:13:38', '2008-04-16 11:16:43');

-- --------------------------------------------------------

--
-- Structure de la table `zones`
--

CREATE TABLE `zones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `surface` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `zones`
--

INSERT INTO `zones` VALUES(1, 'zone_1', 10, '2010-01-27 17:25:13', '2010-03-23 22:03:49');
INSERT INTO `zones` VALUES(4, 'zone_2', 10, '2010-03-22 21:15:04', '2010-03-23 22:03:42');
INSERT INTO `zones` VALUES(5, 'zone_3', 10, '2010-03-23 22:03:31', '2010-03-23 22:03:31');

-- --------------------------------------------------------

--
-- Structure de la table `zonetopas`
--

CREATE TABLE `zonetopas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parcelle_id` int(11) DEFAULT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `value` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Contenu de la table `zonetopas`
--

INSERT INTO `zonetopas` VALUES(4, 8, 1, 10, '2010-03-22 20:34:36', '2010-03-23 22:04:08');
INSERT INTO `zonetopas` VALUES(5, 9, 4, 10, '2010-03-22 20:34:46', '2010-03-23 22:04:25');
INSERT INTO `zonetopas` VALUES(6, 10, 5, 10, '2010-03-23 21:22:05', '2010-03-23 22:04:39');
