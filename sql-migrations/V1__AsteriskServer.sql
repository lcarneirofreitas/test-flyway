CREATE TABLE `AsteriskServer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `privateIP` varchar(255) NOT NULL,
  `publicIP` varchar(255) NOT NULL,
  `installationServer` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
