-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Фев 01 2019 г., 12:52
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
CREATE DEFINER=`root`@`%` PROCEDURE `proc_after_load` (IN `summa` DECIMAL(10,2), IN `client` VARCHAR(255))  MODIFIES SQL DATA
begin
insert IGNORE into clients (clients.naim) VALUES (client);
update clients set clients.balance = clients.balance + summa
	where clients.naim = client; 
	
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `naim` varchar(1000) NOT NULL DEFAULT '',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `clients`
--

INSERT INTO `clients` (`id`, `naim`, `balance`) VALUES
(40, 'Индивидуальный предприниматель Рамазанова Камилла Махачевна', '3002.00'),
(41, 'Индивидуальный предприниматель Рамазанова Камилла Махачевна2', '3002.00'),
(42, 'Индивидуальный предприниматель Рамазанова Камилла Махачевна3', '3002.00'),
(43, 'Индивидуальный предприниматель Рамазанова Камилла Махачевна4', '1505.00');

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
-- Дамп данных таблицы `payments`
--

INSERT INTO `payments` (`id`, `TS`, `plat_vid`, `plat_dataspis`, `plat_innkorr`, `plat_naznachplat`, `plat_naimkorr`, `plat_nomerdocSMFR`, `plat_nomerrasdoc`, `plat_summaplatpokred`, `plat_unicalidplat`) VALUES
(34601, '2019-01-13 12:17:43', 'электронно', '09.01.2019', '891302134629', 'ОПЛАТА ПО ДОГОВОРУ ОКАЗАНИЯ УСЛУГ ПО ТЕХНИЧЕСКОМУ ОБСЛУЖИВАНИЮ ЛВС НДС не облагается.', 'Индивидуальный предприниматель Рамазанова Камилла Махачевна', '1', '1', '3002', '0'),
(34602, '2019-01-13 12:17:43', 'электронно', '09.01.2019', '891302134629', 'ОПЛАТА ПО ДОГОВОРУ ОКАЗАНИЯ УСЛУГ ПО ТЕХНИЧЕСКОМУ ОБСЛУЖИВАНИЮ ЛВС НДС не облагается.', 'Индивидуальный предприниматель Рамазанова Камилла Махачевна2', '1', '1', '3002', '0'),
(34603, '2019-01-13 12:17:43', 'электронно', '09.01.2019', '891302134629', 'ОПЛАТА ПО ДОГОВОРУ ОКАЗАНИЯ УСЛУГ ПО ТЕХНИЧЕСКОМУ ОБСЛУЖИВАНИЮ ЛВС НДС не облагается.', 'Индивидуальный предприниматель Рамазанова Камилла Махачевна3', '1', '1', '3002', '0'),
(34604, '2019-01-13 12:17:43', 'электронно', '09.01.2019', '891302134629', 'ОПЛАТА ПО ДОГОВОРУ ОКАЗАНИЯ УСЛУГ ПО ТЕХНИЧЕСКОМУ ОБСЛУЖИВАНИЮ ЛВС НДС не облагается.', 'Индивидуальный предприниматель Рамазанова Камилла Махачевна4', '1', '1', '1505', '0');

--
-- Триггеры `payments`
--
DELIMITER $$
CREATE TRIGGER `after_ins` AFTER INSERT ON `payments` FOR EACH ROW CALL proc_after_load (new.plat_summaplatpokred, new.plat_naimkorr)
$$
DELIMITER ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Индекс 2` (`naim`(255));

--
-- Индексы таблицы `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Индекс 2` (`plat_vid`,`plat_dataspis`,`plat_innkorr`,`plat_naznachplat`,`plat_naimkorr`,`plat_nomerdocSMFR`,`plat_nomerrasdoc`,`plat_summaplatpokred`,`plat_unicalidplat`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT для таблицы `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34605;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

--