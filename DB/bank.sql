-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Мар 27 2019 г., 08:48
-- Версия сервера: 5.6.41
-- Версия PHP: 5.5.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `bank`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`%` PROCEDURE `proc_after_load` (IN `summa` DECIMAL(10,2), IN `client_naim` VARCHAR(255), IN `client_INN` VARCHAR(255))  MODIFIES SQL DATA
begin
insert IGNORE into clients (clients.naim,clients.INN) VALUES (client_naim, client_INN);
update clients set 
	clients.balance = clients.balance + summa,
	clients.naim = client_naim
where 
	clients.INN = client_INN; 
	
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
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
  `ip_adress` varchar(255) CHARACTER SET cp1251 NOT NULL COMMENT 'IP адрес'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `clients`
--

INSERT INTO `clients` (`id`, `naim`, `balance`, `INN`, `naim_sokr`, `data_dog`, `nom_dog`, `data_nach_tarif`, `tarif_cena`, `telefon`, `adress`, `email`, `ip_adress`) VALUES
(88, 'Индивидуальный предприниматель Дорохина Галина Ивановна', '1500.00', '891302076776', 'аааааа', '', '', '', '', '834936555555 556656656 5656', '', '', ''),
(89, 'ООО \"ТОР-Логистик\"', '20000.00', '8913010243', '', '', '', '', '', '', '', '', ''),
(90, 'ООО НПФ \"АМК ГОРИЗОНТ\"', '25000.00', '0265017673', '', '', '', '', '', '', '', '', ''),
(91, 'Индивидуальный предприниматель Сафонов Валерий Валерьевич', '10000.00', '891300121310', '', '', '', '', '', '', '', '', ''),
(92, 'ООО \"Губкинская ДПО\"', '6000.00', '8913009738', '', '', '', '', '', '', '', '', ''),
(93, 'Крогаль Дмитрий Владимирович', '0.00', '891300979853', '', '', '', '', '', '', '', '', ''),
(94, 'ООО \"НПС\"', '5000.00', '8911029633', '', '', '', '', '', '', '', '', ''),
(95, 'ООО \"ЛАМАС\"', '4000.00', '8911012848', '', '', '', '', '', '', '', '', ''),
(97, 'ООО \"ТК ЯТНП\" р/с 40702810600170500013 в Ф-Л ЗАПАДНО-СИБИРСКИЙ ПАО БАНКА \"ФК ОТКРЫТИЕ\"  г Ханты-Мансийск', '7500.00', '8911026713', '', '', '', '', '', '', '', '', ''),
(98, 'ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ \"АВТОНОМИЯ\"', '4000.00', '8911011386', '', '', '', '', '', '', '', '', ''),
(100, 'Индивидуальный предприниматель Кудряшов Константин Дмитриевич', '3000.00', '891302562409', '', '', '', '', '', '', '', '', ''),
(101, 'ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ \"АВТОРСКАЯ МЕБЕЛЬ\"', '12000.00', '7415056998', '', '', '', '', '', '', '', '', ''),
(102, 'Общество с ограниченной ответственностью \"Агентство Губкинской недвижимости\"', '6000.00', '8911028340', '', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `plat_vid` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_dataspis` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_innkorr` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_naznachplat` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_naimkorr` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_nomerdocSMFR` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_nomerrasdoc` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_summaplatpokred` varchar(255) CHARACTER SET cp1251 NOT NULL,
  `plat_unicalidplat` varchar(255) CHARACTER SET cp1251 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Триггеры `payments`
--
DELIMITER $$
CREATE TRIGGER `after_ins` AFTER INSERT ON `payments` FOR EACH ROW CALL proc_after_load (new.plat_summaplatpokred, new.plat_naimkorr,new.plat_innkorr)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `user_id` int(11) UNSIGNED NOT NULL,
  `user_login` varchar(30) DEFAULT '',
  `user_password` varchar(32) DEFAULT '',
  `user_hash` varchar(32) DEFAULT '',
  `user_ip` int(10) UNSIGNED DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`user_id`, `user_login`, `user_password`, `user_hash`, `user_ip`) VALUES
(1, 'Krogal', 'Krogal', '', 0),
(2, 'Ttt', 'dc9e9e2eaf8da1d634e890b503ee881c', '36084d754e93f35360f3fa3ef6541047', NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Индекс 2` (`INN`);

--
-- Индексы таблицы `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Индекс 2` (`plat_vid`,`plat_dataspis`,`plat_innkorr`,`plat_naznachplat`,`plat_naimkorr`,`plat_nomerdocSMFR`,`plat_nomerrasdoc`,`plat_summaplatpokred`,`plat_unicalidplat`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT для таблицы `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
