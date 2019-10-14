-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  sam. 31 août 2019 à 21:08
-- Version du serveur :  10.1.30-MariaDB
-- Version de PHP :  7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `mangasworld`
--

-- --------------------------------------------------------

--
-- Structure de la table `commentaire`
--

CREATE TABLE `commentaire` (
  `id_commentaire` int(11) NOT NULL,
  `lib_commentaire` text COLLATE utf8_unicode_ci,
  `id_manga` int(11) NOT NULL,
  `id_lecteur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `dessinateur`
--

CREATE TABLE `dessinateur` (
  `id_dessinateur` int(11) NOT NULL,
  `nom_dessinateur` varchar(50) COLLATE utf8_bin NOT NULL,
  `prenom_dessinateur` varchar(50) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `dessinateur`
--

INSERT INTO `dessinateur` (`id_dessinateur`, `nom_dessinateur`, `prenom_dessinateur`) VALUES
(1, 'TITE', 'Kubo'),
(2, 'ONE', ''),
(3, 'TORIYAMA', 'Akira'),
(4, 'YUSUKE', 'Murata'),
(5, 'OBA', 'Tsugumi'),
(6, 'IWAAKI', 'Hitoshi '),
(7, 'OBATA', 'Takeshi '),
(8, 'TOGASHI', 'Yoshihiro ');

-- --------------------------------------------------------

--
-- Structure de la table `genre`
--

CREATE TABLE `genre` (
  `id_genre` int(11) NOT NULL,
  `lib_genre` varchar(50) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `genre`
--

INSERT INTO `genre` (`id_genre`, `lib_genre`) VALUES
(1, 'Aventure'),
(2, 'Tanche-de-vie'),
(3, 'Action'),
(4, 'Science-fiction'),
(5, 'Suspense'),
(6, 'Policier'),
(7, 'Sport');

-- --------------------------------------------------------

--
-- Structure de la table `lecteur`
--

CREATE TABLE `lecteur` (
  `id_lecteur` int(11) NOT NULL,
  `nom` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prenom` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rue` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cp` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ville` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `lecteur`
--

INSERT INTO `lecteur` (`id_lecteur`, `nom`, `prenom`, `rue`, `cp`, `ville`) VALUES
(1, 'Administrateur', '', '', '', ''),
(2, 'Kyroul', 'Pierre', '18, Rue des Cailloux', '69009', 'Lyon');

-- --------------------------------------------------------

--
-- Structure de la table `manga`
--

CREATE TABLE `manga` (
  `id_manga` int(11) NOT NULL,
  `id_dessinateur` int(11) NOT NULL,
  `id_scenariste` int(11) NOT NULL,
  `prix` decimal(10,2) NOT NULL,
  `titre` varchar(250) COLLATE utf8_bin NOT NULL,
  `couverture` varchar(50) COLLATE utf8_bin NOT NULL,
  `id_genre` int(11) NOT NULL,
  `id_lecteur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `manga`
--

INSERT INTO `manga` (`id_manga`, `id_dessinateur`, `id_scenariste`, `prix`, `titre`, `couverture`, `id_genre`, `id_lecteur`) VALUES
(1, 1, 1, '12.50', 'Akatsuki Vol.2', 'akatsuki-02.jpg', 1, 2),
(2, 2, 2, '10.90', 'Collège Fou Fou Fou (le)', 'college-fou-fou-fou.jpg', 2, 2),
(3, 3, 4, '8.75', 'Yu-Gi-Oh ! 5D\'s Vol.9', 'yu-gi-oh-5d-jp-9_m.jpg', 1, 2),
(4, 5, 6, '9.90', 'Hack - Le bracelet du crépuscule', 'hack_01_m.jpg', 1, 2),
(5, 7, 8, '12.25', '7 Yakuzas', '7yakuzas_m.jpg', 3, 2),
(6, 3, 8, '11.78', '7 milliards d\'aiguilles', '7-milliards-aiguilles.jpg', 6, 2);

--
-- Déclencheurs `manga`
--
DELIMITER $$
CREATE TRIGGER `tbi_manga` BEFORE INSERT ON `manga` FOR EACH ROW begin
	declare ck_manga_prix condition for sqlstate '45000';
	if (new.prix <= 0) then
		signal ck_manga_prix set message_text = 'ck_manga_prix : prix négatif.';
	end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tbu_manga` BEFORE UPDATE ON `manga` FOR EACH ROW begin
	declare ck_manga_prix condition for sqlstate '45000';
	if (new.prix <= 0) then
		signal ck_manga_prix set message_text = 'ck_manga_prix : prix négatif.';
	end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `scenariste`
--

CREATE TABLE `scenariste` (
  `id_scenariste` int(11) NOT NULL,
  `nom_scenariste` varchar(50) COLLATE utf8_bin NOT NULL,
  `prenom_scenariste` varchar(50) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `scenariste`
--

INSERT INTO `scenariste` (`id_scenariste`, `nom_scenariste`, `prenom_scenariste`) VALUES
(1, 'TITE', 'Kubo'),
(2, 'ONE', ''),
(3, 'TORIYAMA', 'Akira'),
(4, 'YUSUKE', 'Murata'),
(5, 'OBA', 'Tsugumi'),
(6, 'IWAAKI', 'Hitoshi '),
(7, 'OBATA', 'Takeshi '),
(8, 'TOGASHI', 'Yoshihiro ');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD PRIMARY KEY (`id_commentaire`),
  ADD KEY `fk_commentaire_manga` (`id_manga`),
  ADD KEY `fk_commentaire_lecteur` (`id_lecteur`);

--
-- Index pour la table `dessinateur`
--
ALTER TABLE `dessinateur`
  ADD PRIMARY KEY (`id_dessinateur`);

--
-- Index pour la table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`id_genre`);

--
-- Index pour la table `lecteur`
--
ALTER TABLE `lecteur`
  ADD PRIMARY KEY (`id_lecteur`);

--
-- Index pour la table `manga`
--
ALTER TABLE `manga`
  ADD PRIMARY KEY (`id_manga`),
  ADD KEY `fk_manga_genre` (`id_genre`),
  ADD KEY `fk_manga_scenariste` (`id_scenariste`),
  ADD KEY `fk_manga_dessinateur` (`id_dessinateur`),
  ADD KEY `fk_manga_lecteur` (`id_lecteur`);

--
-- Index pour la table `scenariste`
--
ALTER TABLE `scenariste`
  ADD PRIMARY KEY (`id_scenariste`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `commentaire`
--
ALTER TABLE `commentaire`
  MODIFY `id_commentaire` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `dessinateur`
--
ALTER TABLE `dessinateur`
  MODIFY `id_dessinateur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `lecteur`
--
ALTER TABLE `lecteur`
  MODIFY `id_lecteur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `manga`
--
ALTER TABLE `manga`
  MODIFY `id_manga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `scenariste`
--
ALTER TABLE `scenariste`
  MODIFY `id_scenariste` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD CONSTRAINT `fk_commentaire_lecteur` FOREIGN KEY (`id_lecteur`) REFERENCES `lecteur` (`id_lecteur`),
  ADD CONSTRAINT `fk_commentaire_manga` FOREIGN KEY (`id_manga`) REFERENCES `manga` (`id_manga`);

--
-- Contraintes pour la table `manga`
--
ALTER TABLE `manga`
  ADD CONSTRAINT `fk_manga_dessinateur` FOREIGN KEY (`id_dessinateur`) REFERENCES `dessinateur` (`id_dessinateur`),
  ADD CONSTRAINT `fk_manga_genre` FOREIGN KEY (`id_genre`) REFERENCES `genre` (`id_genre`),
  ADD CONSTRAINT `fk_manga_lecteur` FOREIGN KEY (`id_lecteur`) REFERENCES `lecteur` (`id_lecteur`),
  ADD CONSTRAINT `fk_manga_scenariste` FOREIGN KEY (`id_scenariste`) REFERENCES `scenariste` (`id_scenariste`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
