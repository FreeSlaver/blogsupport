CREATE DATABASE IF NOT EXISTS db_blog DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE db_blog;

CREATE TABLE `t_baidu_index` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `domain_name` VARCHAR(128) NOT NULL,
  `verify_code` VARCHAR(12) NOT NULL ,
  `verify_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0:not verify;1:verified',
  `resolve_addr` VARCHAR(128) NOT NULL  DEFAULT "198.74.48.82",
  `github_pages_url` VARCHAR(256) NOT NULL DEFAULT "https://xxx.github.io",
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY(`domain_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='百度索引表';




