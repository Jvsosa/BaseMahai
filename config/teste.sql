-- --------------------------------------------------------
-- Anfitrião:                    127.0.0.1
-- Versão do servidor:           10.4.24-MariaDB - mariadb.org binary distribution
-- SO do servidor:               Win64
-- HeidiSQL Versão:              12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- A despejar dados para tabela creative.groups_anuncios: ~0 rows (aproximadamente)
INSERT INTO `groups_anuncios` (`id`, `empresa`, `nome`, `passaporte`, `color`, `data`, `mensagem`) VALUES
	(1, 'Staff', 'Eduardo Silva', 1, '#295CDE', '18/03/2023 (23:28)', 'teste');
INSERT INTO `groups_anuncios` (`id`, `empresa`, `nome`, `passaporte`, `color`, `data`, `mensagem`) VALUES
	(2, 'Staff', 'Eduardo Silva', 1, '#295CDE', '18/03/2023 (23:28)', 'test');

-- A despejar dados para tabela creative.groups_chat: ~0 rows (aproximadamente)
INSERT INTO `groups_chat` (`id`, `empresa`, `nome`, `passaporte`, `data`, `mensagem`) VALUES
	(1, 'Staff', 'Eduardo Silva', 1, '18/03/2023 (23:29)', 'teste');
INSERT INTO `groups_chat` (`id`, `empresa`, `nome`, `passaporte`, `data`, `mensagem`) VALUES
	(2, 'Staff', 'Eduardo Silva', 1, '18/03/2023 (23:29)', 'teste');

-- A despejar dados para tabela creative.groups_empresas: ~0 rows (aproximadamente)
INSERT INTO `groups_empresas` (`empresa`, `banco`, `avisos`, `vendas`) VALUES
	('Staff', 0, 0, 0);

-- A despejar dados para tabela creative.groups_perfil: ~0 rows (aproximadamente)
INSERT INTO `groups_perfil` (`user_id`, `nome`, `empresa`, `cargo`, `groupSetado`, `img`, `login`, `discordid`, `contratante`, `blacklist`) VALUES
	(1, 'Eduardo Silva', 'Staff', 'Nenhum', 'Nenhum', 'https://cdn.discordapp.com/attachments/452891038349262849/959382742624260136/unknown.png', 1679181226, '0', 'Sistema', NULL);

-- A despejar dados para tabela creative.groups_vendas: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
