alter table blog_posts add `city_id` int(11) DEFAULT 1;
alter table boxes add   `city_id` int(11) DEFAULT 1;
alter table single_events add   `city_id` int(11) DEFAULT 1;
alter table suggestions add   `city_id` int(11) DEFAULT 1;


DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `default` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


INSERT INTO cities SET id=1,name="Köln", created_at=NOW(), updated_at=NOW();
INSERT INTO cities SET id=2,name="Berlin", created_at=NOW(), updated_at=NOW();
