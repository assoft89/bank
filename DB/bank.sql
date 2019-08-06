-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.6.43 - MySQL Community Server (GPL)
-- Операционная система:         Win32
-- HeidiSQL Версия:              10.1.0.5464
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Дамп структуры базы данных bank
DROP DATABASE IF EXISTS `bank`;
CREATE DATABASE IF NOT EXISTS `bank` /*!40100 DEFAULT CHARACTER SET cp1251 */;
USE `bank`;

-- Дамп структуры для таблица bank.clients
DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `naim` varchar(1000) NOT NULL DEFAULT '',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `INN` varchar(255) NOT NULL DEFAULT '''''',
  `naim_sokr` varchar(255) CHARACTER SET cp1251 NOT NULL COMMENT 'Сокр. наим. орг.',
  `data_dog` varchar(255) CHARACTER SET cp1251 NOT NULL COMMENT 'Дата договора',
  `nom_dog` varchar(255) CHARACTER SET cp1251 NOT NULL COMMENT 'Номер договора',
  `data_nach_tarif` varchar(255) CHARACTER SET cp1251 NOT NULL COMMENT 'Дата начала тарифа',
  `tarif_cena` varchar(255) CHARACTER SET cp1251 NOT NULL COMMENT 'Тариф цена',
  `telefon` varchar(255) CHARACTER SET cp1251 NOT NULL COMMENT 'Телефон',
  `adress` varchar(255) CHARACTER SET cp1251 COLLATE cp1251_general_cs NOT NULL COMMENT 'Адрес',
  `email` varchar(255) CHARACTER SET cp1251 NOT NULL COMMENT 'Эл. почта',
  `ip_adress` varchar(255) CHARACTER SET cp1251 NOT NULL COMMENT 'IP адрес',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 2` (`INN`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы bank.clients: ~0 rows (приблизительно)
DELETE FROM `clients`;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` (`id`, `naim`, `balance`, `INN`, `naim_sokr`, `data_dog`, `nom_dog`, `data_nach_tarif`, `tarif_cena`, `telefon`, `adress`, `email`, `ip_adress`) VALUES
	(1, 'Крогаль Дмитрий Владимирович', 0.00, '891300979853', '', '', '', '', '', '', '', '', ''),
	(2, 'ЧУ ДПО РУЦО ЛЕГИОН', 2000.00, '8904062541', '', '', '', '', '', '', '', '', '');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;

-- Дамп структуры для таблица bank.payments
DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `plat_vid` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_dataspis` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_innkorr` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_naznachplat` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_naimkorr` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_nomerdocSMFR` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_nomerrasdoc` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_summaplatpokred` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_unicalidplat` varchar(255) CHARACTER SET cp1251 NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 2` (`plat_vid`,`plat_dataspis`,`plat_innkorr`,`plat_naznachplat`,`plat_naimkorr`,`plat_nomerdocSMFR`,`plat_nomerrasdoc`,`plat_summaplatpokred`,`plat_unicalidplat`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы bank.payments: ~0 rows (приблизительно)
DELETE FROM `payments`;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` (`id`, `TS`, `plat_vid`, `plat_dataspis`, `plat_innkorr`, `plat_naznachplat`, `plat_naimkorr`, `plat_nomerdocSMFR`, `plat_nomerrasdoc`, `plat_summaplatpokred`, `plat_unicalidplat`) VALUES
	(1, '2019-08-06 17:25:17', 'электронно', '31.07.2019', '891300979853', 'НДС не облагается.', 'Крогаль Дмитрий Владимирович', '20', '20', '', ''),
	(2, '2019-08-06 17:25:17', 'электронно', '31.07.2019', '8904062541', 'ОПЛАТА ЗА ИНТЕРНЕТ ПО ДОГОВОРУ ЛВС №25-0103/2019 ОТ 01.02.2019 СУММА 2000-00 БЕЗ НАЛОГА (НДС)', 'ЧУ ДПО РУЦО ЛЕГИОН', '690', '690', '2000', '');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;

-- Дамп структуры для процедура bank.proc_after_load
DROP PROCEDURE IF EXISTS `proc_after_load`;
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `proc_after_load`(IN `summa` DECIMAL(10,2), IN `client_naim` VARCHAR(255), IN `client_INN` VARCHAR(255))
    MODIFIES SQL DATA
begin
insert IGNORE into clients (clients.naim,clients.INN) VALUES (client_naim, client_INN);
update clients set 
	clients.balance = clients.balance + summa,
	clients.naim = client_naim
where 
	clients.INN = client_INN; 
	
end//
DELIMITER ;

-- Дамп структуры для таблица bank.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(30) DEFAULT '',
  `user_password` varchar(32) DEFAULT '',
  `user_hash` varchar(32) DEFAULT '',
  `user_ip` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы bank.users: ~2 rows (приблизительно)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`user_id`, `user_login`, `user_password`, `user_hash`, `user_ip`) VALUES
	(1, 'Krogal', 'Krogal', '', 0),
	(2, 'Ttt', 'dc9e9e2eaf8da1d634e890b503ee881c', '36084d754e93f35360f3fa3ef6541047', NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Дамп структуры для триггер bank.after_ins
DROP TRIGGER IF EXISTS `after_ins`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `after_ins` AFTER INSERT ON `payments` FOR EACH ROW CALL proc_after_load (new.plat_summaplatpokred, new.plat_naimkorr,new.plat_innkorr)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
