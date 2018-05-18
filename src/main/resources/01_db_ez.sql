CREATE DATABASE IF NOT EXISTS db_ez DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci; 
USE db_ez;

CREATE TABLE `t_area` (
  `aid` int(10) NOT NULL AUTO_INCREMENT COMMENT '������',
  `name` varchar(100) DEFAULT NULL COMMENT '��������',
  `paid` varchar(80) DEFAULT NULL COMMENT '��������',
  `aids` varchar(200) DEFAULT NULL COMMENT '������ȫ·��',
  `area_code` int(10) DEFAULT '0' COMMENT '�̻�����',
  `zip` varchar(10) DEFAULT NULL COMMENT '�ʱ�',
  `level` int(4) DEFAULT NULL COMMENT '���㼶��',
  `sort_id` int(11) DEFAULT NULL COMMENT 'ͬ����ʾ���������',
  `create_time` datetime DEFAULT NULL COMMENT '����ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '����޸�ʱ��',
  `status` char(1) DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='������Ϣ';

CREATE TABLE `t_book_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `package_id` varchar(40) DEFAULT NULL COMMENT '������',
  `box_type` varchar(20) DEFAULT NULL COMMENT '�������,big,small,etc',
  `book_type` varchar(45) DEFAULT NULL COMMENT 'ԤԼ����',
  `take_uid` bigint(20) DEFAULT NULL COMMENT '�ռ���ID',
  `take_mobile` varchar(15) DEFAULT NULL COMMENT '�ռ����ֻ�',
  `postman_uid` bigint(20) DEFAULT NULL COMMENT '���ԱID',
  `postman_mobile` varchar(15) DEFAULT NULL COMMENT '���Ա�ֻ�',
  `postman_name` varchar(50) DEFAULT NULL COMMENT '���Ա����',
  `start_time` datetime DEFAULT NULL COMMENT 'ԤԼ��ʼʱ��',
  `end_time` datetime DEFAULT NULL COMMENT 'ԤԼ����ʱ��',
  `book_time_span` int(11) DEFAULT NULL COMMENT 'ԤԼʱ��',
  `callback_url` varchar(256) DEFAULT NULL COMMENT '�ص���ַ',
  `status` varchar(20) DEFAULT NULL COMMENT '״̬��valid-��Ч��fail-ʧ�ܣ�callback_fail-�ص�ʧ�ܣ�success-�ɹ�,cancel-�Ŷ�ȡ��',
  `create_time` datetime DEFAULT NULL COMMENT '����ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '����ʱ��',
  `sn` varchar(20) NOT NULL COMMENT '�ն˺�',
  `parcel_id` varchar(100) NOT NULL COMMENT '����id',
  `company_id` bigint(20) DEFAULT NULL COMMENT '��ݹ�˾id',
  `box_id` varchar(40) DEFAULT NULL COMMENT '�ŶӴ���ɹ�֮����boxId',
  `role` varchar(45) DEFAULT NULL  COMMENT '�����˽�ɫ',
  `updator` varchar(45) DEFAULT NULL  COMMENT '�������ֻ�����',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `idx_package_id` (`package_id`),
  KEY `idx_box_type` (`box_type`),
  KEY `idx_start_time` (`start_time`),
  KEY `idx_end_time` (`end_time`),
  KEY `idx_sn` (`sn`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_box` (
  `box_id` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '���ID��ȫ��Ψһ����ʽ��sn+�������ڸù��ϵ����',
  `sn` varchar(20) COLLATE utf8_bin DEFAULT '������',
  `cabinet_id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'ȫ��Ψһ��ţ�ͬ�ʲ�����ID',
  `box_type` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '������ͣ��磺���С�С������',
  `box_type_id` int(10) DEFAULT '0' COMMENT '�����ϸ����ID����Ӧ t_box_type.box_type_id',
  `box_status` char(1) NOT NULL COLLATE utf8_bin DEFAULT 'r' COMMENT '���״̬���磺r-����������; e-������',
  `box_use_status` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '���ʹ��״̬����:empty-����; reserved-Ԥ��; book-ԤԼ; used-ռ��',
  `layout_col` int(10) NOT NULL COMMENT '�к�(��λ�����)',
  `layout_row` int(10) NOT NULL COMMENT '�к�(��λ�����)',
  `layout_elect` int(10) NOT NULL COMMENT '�������(ӳ�����-���������ã�ӳ���ϵ����*�У��������)',
  `update_time` datetime DEFAULT NULL COMMENT '�������ʱ��',
  `create_time` datetime DEFAULT NULL COMMENT '¼��ʱ��',
  `status` char(1) NOT NULL COLLATE utf8_bin DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  PRIMARY KEY (`box_id`),
  KEY `sn` (`sn`),
  KEY `cabinet_id` (`cabinet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='�����Ϣ��';

CREATE TABLE `t_box_layout` (
  `cabinet_type_id` int(11) NOT NULL COMMENT '����ID(�ڲ�����)',
  `col` int(11) NOT NULL COMMENT '����',
  `row` int(11) NOT NULL COMMENT '����',
  `box_type` varchar(20) NOT NULL COMMENT '��������ͣ��磺���С�С������',
  `box_type_id` int(11) NOT NULL COMMENT '������ϸ���ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='box���ֹ�ϵ��';

CREATE TABLE `t_box_sync` (
  `box_id` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '���ID��ȫ��Ψһ����ʽ��sn+�������ڸù��ϵ����',
  `sn` varchar(20) COLLATE utf8_bin DEFAULT '������',
  `cabinet_id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'ȫ��Ψһ��ţ�ͬ�ʲ�����ID',
  `box_type` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '������ͣ��磺���С�С������',
  `box_type_id` int(10) DEFAULT '0' COMMENT '�����ϸ����ID����Ӧ t_box_type.box_type_id',
  `box_status` char(1) COLLATE utf8_bin DEFAULT 'r' COMMENT '���״̬���磺r-����������; e-������',
  `box_use_status` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '���ʹ��״̬����:empty-����; reserved-Ԥ��; book-ԤԼ; used-ռ��',
  `layout_col` int(10) NOT NULL COMMENT '�к�(��λ�����)',
  `layout_row` int(10) NOT NULL COMMENT '�к�(��λ�����)',
  `layout_elect` int(10) NOT NULL COMMENT '�������(ӳ�����-���������ã�ӳ���ϵ����*�У��������)',
  `update_time` datetime DEFAULT NULL COMMENT '�������ʱ��',
  `create_time` datetime DEFAULT NULL COMMENT '¼��ʱ��',
  `status` char(1) COLLATE utf8_bin DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  PRIMARY KEY (`box_id`),
  KEY `sn` (`sn`),
  KEY `cabinet_id` (`cabinet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='�����Ϣ��';

CREATE TABLE `t_box_type` (
  `box_type_id` int(11) NOT NULL COMMENT 'box��ϸ���ID(�ڲ�����)',
  `name` varchar(50) DEFAULT NULL COMMENT '���͹������',
  `box_type` varchar(20) NOT NULL COMMENT '��������ͣ��磺���С�С������',
  `width` varchar(5) DEFAULT NULL COMMENT '���(mm)',
  `height` varchar(5) DEFAULT NULL COMMENT '�䳤��(mm)',
  `deep` varchar(5) DEFAULT NULL COMMENT '���(mm)',
  `status` char(1) DEFAULT NULL COMMENT '״̬��y-��Ч; n-��Ч',
  `creater` varchar(32) DEFAULT NULL COMMENT '������',
  `updater` varchar(32) DEFAULT NULL COMMENT '����޸���',
  `create_time` datetime DEFAULT NULL COMMENT '����ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '����޸�ʱ��',
  PRIMARY KEY (`box_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='box��ϸ����';

CREATE TABLE `t_cabinet` (
  `cabinet_id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'ȫ��Ψһ��ţ�ͬ�ʲ�����ID',
  `serial_num` varchar(40) COLLATE utf8_bin DEFAULT '' COMMENT '�������(��Ӧ���ṩ�������ظ�)',
  `sn` varchar(20) COLLATE utf8_bin DEFAULT '0' COMMENT '�����ţ���Ϊ��(δ���������ʱ)',
  `cabinet_type_id` int(11) NOT NULL COMMENT '����ID',
  `sort` int(11) DEFAULT '99' COMMENT '�����ڹ���˳��ţ���0��ʼ������������',
  `color` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '������ɫ',
  `pos_phy` int(10) DEFAULT '0' COMMENT '����λ�����(������Ψһ)',
  `pos_elect` int(10) DEFAULT '0' COMMENT '�����������(������Ψһ)',
  `fuse_time` datetime DEFAULT NULL COMMENT '�״�Ͷ��ʹ��ʱ��',
  `luse_time` datetime DEFAULT NULL COMMENT '���Ͷ��ʹ��ʱ��(�ɶ��Ͷ��ʹ��)',
  `update_time` datetime DEFAULT NULL COMMENT '�������ʱ��',
  `create_time` datetime DEFAULT NULL COMMENT '¼��ʱ��',
  `status` varchar(10) COLLATE utf8_bin DEFAULT 'init' COMMENT '״̬��init-��ʼ��; testrun-����Ӫ; run-��Ӫ��; breakdown-����; abandon-����',
  PRIMARY KEY (`cabinet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='������Ϣ��';

CREATE TABLE `t_cabinet_type` (
  `cabinet_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '����ID(�ڲ�����)',
  `supplier_id` int(11) NOT NULL COMMENT '�豸��Ӧ��ID',
  `cabinet_type` varchar(40) NOT NULL COMMENT '��������(��Ӧ���ṩ�����ų���ͬ��Ӧ��֮������ͬ�Ʒ�)',
  `deep` int(11) NOT NULL COMMENT '���ӳ���(��λ������)-��������',
  `width` int(11) NOT NULL COMMENT '���ӿ��(��λ������)-����������',
  `height` int(11) NOT NULL COMMENT '���Ӹ߶�(��λ������)-����ߵ��',
  `weight` int(11) NOT NULL COMMENT '��������(��λ������)-�Ǿ�ȷֵ',
  `use_type` int(4) NOT NULL COMMENT '�������ͣ�0-����;1-����;2-��͹�',
  `is_probe` char(1) NOT NULL DEFAULT 'n' COMMENT '�Ƿ���̽��ͷ��y-��Ч; n-��Ч',
  `in_out` varchar(5) DEFAULT NULL COMMENT '���ͣ�in-���ڻ�; out-�����',
  `cbox_num` int(10) DEFAULT '0' COMMENT '�����',
  `layout` text COMMENT '��񲼾ֺ͹��(json) {�к�:{�к�:�������, ...} ,...}; ���������[smallmiddleigsbigcomputer]',
  `note` text COMMENT '˵��',
  `creator` varchar(32) DEFAULT NULL COMMENT '������',
  `updater` varchar(32) DEFAULT NULL COMMENT '����޸���',
  `create_time` datetime DEFAULT NULL COMMENT '����ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '����޸�ʱ��',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  PRIMARY KEY (`cabinet_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='�豸�ṩ���ṩ��cabinet���ͱ�';

CREATE TABLE `t_channel` (
  `channel_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ҵ������ID',
  `channel` varchar(60) DEFAULT NULL COMMENT 'ҵ������',
  `creator` varchar(32) DEFAULT NULL COMMENT '������',
  `updater` varchar(32) DEFAULT NULL COMMENT '����޸���',
  `create_time` datetime DEFAULT NULL COMMENT '����ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '����޸�ʱ��',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  PRIMARY KEY (`channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='ҵ��������';

CREATE TABLE `t_city` (
  `city_id` int(10) NOT NULL COMMENT '����ID��Ψһ��־',
  `city` varchar(50) NOT NULL COMMENT '��������',
  `province` varchar(20) NOT NULL COMMENT 'ʡ������(��ֱϽ��)������ʡ(��)�֣��磺�㶫���Ϻ�',
  `note` text COMMENT '�򵥵��������е���Ϣ���ɿ�',
  `create_time` datetime NOT NULL COMMENT '������Ϣ�ύʱ��',
  `status` char(1) DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  `zip_code` int(6) NOT NULL DEFAULT '0' COMMENT '�ʱ����',
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='������Ϣ��';

CREATE TABLE `t_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `config_key` varchar(128) NOT NULL COMMENT 'ϵͳ������',
  `config_value` varchar(128) NOT NULL COMMENT 'ϵͳ����ֵ',
  `config_desc` varchar(256) NOT NULL COMMENT 'ϵͳ��������',
  `config_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '�������ͣ�1-��ͨ���ã�2-��������',
  `is_global` char(1) NOT NULL DEFAULT 'y' COMMENT '״̬��y-ȫ������; n-�ֲ�����(ʵ�ʷ�Χ���·�ʱָ��)',
  `creator` varchar(32) NOT NULL COMMENT '������',
  `updater` varchar(32) NOT NULL COMMENT '������',
  `create_time` datetime NOT NULL COMMENT '����ʱ��',
  `update_time` datetime NOT NULL COMMENT '�޸�ʱ��',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='�ն����ñ�';

CREATE TABLE `t_config_biz_term` (
  `sn` varchar(20) NOT NULL COMMENT '������',
  `datanode` varchar(30) DEFAULT '0' COMMENT 'Datanode ��ַ����ʽ�� IP:Port',
  `creator` varchar(32) NOT NULL COMMENT '������',
  `create_time` datetime NOT NULL COMMENT '����ʱ��',
  PRIMARY KEY (`sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�ն˻Ҷ����ñ�';

CREATE TABLE `t_config_blacklist` (
  `blacklist_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `type` varchar(20) NOT NULL COMMENT '�������ͣ�taker-ȡ����(�ֻ���); pkg-�˵�(�˵���)',
  `value` varchar(60) NOT NULL COMMENT 'type��Ӧ�����ֵ����type=takerʱ���ֻ���; type=pkgʱ���˵���',
  `creator` varchar(32) NOT NULL COMMENT '������',
  `updater` varchar(32) NOT NULL COMMENT '������',
  `create_time` datetime NOT NULL COMMENT '����ʱ��',
  `update_time` datetime NOT NULL COMMENT '�޸�ʱ��',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  PRIMARY KEY (`blacklist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='���������ñ�';

CREATE TABLE `t_config_launch` (
  `launch_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `config_id` int(11) unsigned NOT NULL COMMENT '����ID',
  `bjob_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '��������ID',
  `config_key` varchar(128) NOT NULL COMMENT '��������',
  `config_value` varchar(128) NOT NULL COMMENT '����ֵ',
  `config_desc` varchar(256) NOT NULL COMMENT '��������',
  `config_type` tinyint(1) NOT NULL COMMENT '��������',
  `creator` varchar(32) NOT NULL COMMENT '������',
  `updater` varchar(32) NOT NULL COMMENT '������',
  `create_time` datetime NOT NULL COMMENT '����ʱ��',
  `update_time` datetime NOT NULL COMMENT '�޸�ʱ��',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  PRIMARY KEY (`launch_id`),
  KEY `config_id` (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='�ն������·���';

CREATE TABLE `t_config_launch_term` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sn` varchar(36) NOT NULL COMMENT '�ն˱��',
  `config_id` int(11) unsigned NOT NULL COMMENT '����ID',
  `launch_id` int(11) unsigned NOT NULL COMMENT '�·�ID',
  `launch_status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '�·�״̬��1-δ�·���2-�·�ʧ�ܣ�3-�·��ɹ�',
  `launch_time` datetime DEFAULT NULL COMMENT '�·�ʱ��',
  `create_time` datetime NOT NULL COMMENT '����ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '�޸�ʱ��',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  PRIMARY KEY (`id`),
  KEY `sn` (`sn`),
  KEY `config_id` (`config_id`),
  KEY `launch_id` (`launch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='�ն������·��ն��б�';

CREATE TABLE `t_department` (
  `did` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '������',
  `dids` varchar(200) DEFAULT NULL COMMENT '����ȫ·��',
  `dname` varchar(80) DEFAULT NULL COMMENT '��������',
  `area_id` varchar(200) DEFAULT NULL COMMENT '��������',
  `address` varchar(100) DEFAULT NULL COMMENT '��ϸ��ַ',
  `zip` varchar(10) DEFAULT NULL COMMENT '�ʱ�',
  `parent_id` varchar(20) DEFAULT NULL COMMENT '��������',
  `level` varchar(3) DEFAULT NULL COMMENT '���㼶��',
  `sort_id` int(11) DEFAULT NULL COMMENT 'ͬ����ʾ���������',
  `remark` varchar(200) DEFAULT NULL COMMENT '��ע',
  `creator` varchar(32) DEFAULT NULL COMMENT '������',
  `updater` varchar(32) DEFAULT NULL COMMENT '����޸���',
  `create_time` datetime DEFAULT NULL COMMENT '����ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '����޸�ʱ��',
  `contact_person` varchar(60) DEFAULT NULL COMMENT '��ϵ��',
  `contact_tel` varchar(20) DEFAULT NULL COMMENT '��ϵ�˵绰',
  `status` char(1) DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  PRIMARY KEY (`did`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='��Ӫ������Ϣ';

CREATE TABLE `t_department_sync` (
  `did` bigint(20) NOT NULL AUTO_INCREMENT,
  `dids` varchar(200) DEFAULT NULL,
  `dname` varchar(80) DEFAULT NULL,
  `area_id` varchar(200) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `parent_id` varchar(20) DEFAULT NULL,
  `level` varchar(3) DEFAULT NULL,
  `sort_id` int(11) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `creator` varchar(32) DEFAULT NULL,
  `updater` varchar(32) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `contact_person` varchar(60) DEFAULT NULL,
  `contact_tel` varchar(20) DEFAULT NULL,
  `status` char(1) DEFAULT 'y' COMMENT 'y-; n-',
  PRIMARY KEY (`did`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_express_company` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '��ݹ�˾��',
  `status` tinyint(2) DEFAULT '1' COMMENT '����״̬��1 ���� 0 ��ֹ',
  `add_time` datetime DEFAULT NULL,
  `add_user` varchar(32) NOT NULL DEFAULT '' COMMENT '�����',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��ݹ�˾��Ϣ��';

CREATE TABLE `t_external_device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `external_device_id` varchar(32) DEFAULT NULL COMMENT '����id',
  `external_device_type` varchar(32) DEFAULT NULL COMMENT '��������',
  `com_port_no` int(11) DEFAULT NULL COMMENT '�����Ӧ��COM',
  `adapter_class` text COMMENT '�������',
  `create_time` datetime DEFAULT NULL COMMENT '����ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '����޸�ʱ��',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  `sn` varchar(20) NOT NULL COMMENT '�����������ţ�6λ�ʱ�+1λ��ĸ+3λ���ڱ��',
  PRIMARY KEY (`id`),
  KEY `external_device_id_index` (`external_device_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='�����';

CREATE TABLE `t_ez_app` (
  `app_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'Ӧ��ID',
  `type` varchar(20) DEFAULT NULL COMMENT 'Ӧ�����ͣ�termiosandriod',
  `note` text COMMENT 'Ӧ��˵��',
  `creator` varchar(32) DEFAULT NULL,
  `updater` varchar(32) DEFAULT NULL COMMENT '��������',
  `create_time` datetime DEFAULT NULL COMMENT '��������',
  `update_time` datetime DEFAULT NULL COMMENT '����������',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  PRIMARY KEY (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='Ӧ�ó�������';

CREATE TABLE `t_ez_app_launch` (
  `launch_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `vid` int(11) unsigned NOT NULL COMMENT '�汾ID',
  `bjob_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '��������ID',
  `launch_type` tinyint(3) unsigned NOT NULL COMMENT '�·�����',
  `version` varchar(32) NOT NULL COMMENT '�汾��',
  `update_file` varchar(32) NOT NULL DEFAULT '' COMMENT '�����ļ�ID',
  `desc_file` varchar(32) NOT NULL DEFAULT '' COMMENT '�����ļ�ID',
  `creator` varchar(32) NOT NULL COMMENT '������',
  `updater` varchar(32) DEFAULT NULL COMMENT '������',
  `create_time` datetime NOT NULL COMMENT '����ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '�޸�ʱ��',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  PRIMARY KEY (`launch_id`),
  KEY `vid` (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='�汾�·���¼��';

CREATE TABLE `t_ez_app_launch_term` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sn` varchar(36) NOT NULL COMMENT '�ն˱��',
  `vid` int(11) unsigned NOT NULL COMMENT '�汾ID',
  `launch_id` int(11) unsigned NOT NULL COMMENT '�·�ID',
  `launch_type` tinyint(3) unsigned NOT NULL COMMENT '�·�����',
  `launch_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '�·�״̬��1-δ�·���2-�·�ʧ�ܣ�3-�·��ɹ���4-����ʧ�ܣ�5-���سɹ���6-��װʧ�ܣ�7-��װ�ɹ�',
  `launch_time` datetime DEFAULT NULL COMMENT '�·�ʱ��',
  `download_time` datetime DEFAULT NULL COMMENT '����ʱ��',
  `install_time` datetime DEFAULT NULL COMMENT '��װʱ��',
  `create_time` datetime NOT NULL COMMENT '����ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '�޸�ʱ��',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  PRIMARY KEY (`id`),
  KEY `sn` (`sn`),
  KEY `vid` (`vid`),
  KEY `launch_id` (`launch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='�汾�·��ն��б�';

CREATE TABLE `t_ez_app_version` (
  `vid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '�汾���',
  `app_id` int(10) DEFAULT '0' COMMENT '����Ӧ��ID',
  `version` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '�汾��',
  `md5` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'Ӧ���ļ�MD5ֵ',
  `iurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'Ӧ���ļ��ڲ����ص�ַ/����·��',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'Ӧ���ļ��ⲿ���ص�ַ(��������/CDN)',
  `updater` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '��������',
  `update_time` datetime DEFAULT NULL COMMENT '����������',
  `create_time` datetime DEFAULT NULL COMMENT '��������',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  `creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `update_file` varchar(32) NOT NULL DEFAULT '' COMMENT '�����ļ�ID',
  `desc_file` varchar(32) NOT NULL DEFAULT '' COMMENT '�����ļ�ID',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `version` (`version`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='�ն�Ӧ�ð汾����';

CREATE TABLE `t_ez_upload_file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` varchar(32) NOT NULL COMMENT '�ļ�ID/�ļ���',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '״̬',
  `cate` tinyint(1) unsigned NOT NULL COMMENT '�ļ����',
  `md5` varchar(64) NOT NULL COMMENT '�ļ�MD5',
  `name` varchar(64) NOT NULL COMMENT '�ļ�ԭʼ����',
  `ext` varchar(8) NOT NULL COMMENT '��չ��',
  `size` int(11) unsigned NOT NULL COMMENT '�ļ���С����λ�ֽ�',
  `creator` varchar(32) NOT NULL COMMENT '������',
  `updater` varchar(32) NOT NULL COMMENT '������',
  `create_time` datetime NOT NULL COMMENT '����ʱ��',
  `update_time` datetime NOT NULL COMMENT '�޸�ʱ��',
  PRIMARY KEY (`id`),
  UNIQUE KEY `file_id` (`file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='Eջ�����̨�ϴ��ļ���';

CREATE TABLE `t_notify_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `type` varchar(20) NOT NULL COMMENT '֪ͨ���ͣ�ȡ����-take;����֪ͨ-expire;����-urge;etc',
  `channel` varchar(20) NOT NULL COMMENT '֪ͨ����������-sms;΢��-wechat;B��APP-app_biz;C��App-app_cuz;����ԱApp-app_opt;',
  `rid` varchar(60) DEFAULT '0' COMMENT '��������ID������-parcel_id; etc',
  `tpl_code` varchar(30) DEFAULT 'null' COMMENT '֪ͨģ��code��������Ϊ��',
  `msg` varchar(256) NOT NULL COMMENT '֪ͨ���ݣ���������ģ���еı���',
  `toid` varchar(60) NOT NULL COMMENT '֪ͨ���󣬸���channel����sms-�ֻ���; wechat-openid(�����ֹ��ں�); app_xxx-�û�uid(��Ϊ���������û�ʹ��ͬһ��uid)',
  `note` varchar(60) DEFAULT NULL COMMENT '֪ͨ˵��',
  `ret` tinyint(1) DEFAULT '0' COMMENT '֪ͨ�����1-�ɹ�;0-ʧ��',
  `creator` varchar(32) DEFAULT '' COMMENT '������',
  `create_time` datetime NOT NULL COMMENT '����ʱ��',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='֪ͨ��¼��';

CREATE TABLE `t_opt_term` (
  `uid` varchar(20) NOT NULL COMMENT '��ά��ԱUID(���Ի�Աϵͳ)',
  `mobile` varchar(20) NOT NULL COMMENT '��ά��Աmobile&��½�˺�(���Ի�Աϵͳ)',
  `name` varchar(60) DEFAULT '' COMMENT '��ά��Ա����(���Ի�Աϵͳ)',
  `did` varchar(20) NOT NULL DEFAULT '' COMMENT '��Ӫ������',
  `create_time` datetime NOT NULL COMMENT '����ʱ��',
  `dids` varchar(80) NOT NULL DEFAULT '' COMMENT '��Ӫ����㼶��ϵ',
  KEY `idx_sn_mobile` (`mobile`),
  KEY `idx_did` (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�ն� -��ά��Ա��Ӧ��ϵ��';


CREATE TABLE `t_parcel` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '����ID��eջ�����ɣ�ȫ��Ψһ',
  `package_id` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '�˵���(��ݹ�˾����)',
  `sn` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '�����ţ�ȫ��Ψһ',
  `box_id` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '���ID��ȫ��Ψһ',
  `book_type` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT 'ԤԼ����',
  `take_code` varchar(36) COLLATE utf8_bin NOT NULL COMMENT 'ȡ����',
  `retrieve_code` varchar(36) COLLATE utf8_bin NOT NULL COMMENT '������(�ݲ����ֹ���Ա|���Ա����)',
  `code_expire_time` datetime NOT NULL COMMENT 'ԤԼ�롢ȡ���롢������ʧЧ��(ͬһ�������ɣ��ʿ���ͬʱʧЧ)',
  `take_uid` bigint(20) DEFAULT NULL COMMENT '�ռ���ID',
  `take_mobile` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT '�ռ����ֻ�(����)',
  `pickup_uid` bigint(20) DEFAULT NULL COMMENT 'ȡ����ID',
  `pickup_mobile` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT 'ȡ�����ֻ�(����)',
  `postman_uid` bigint(20) DEFAULT NULL COMMENT 'Ͷ��Ա���',
  `postman_mobile` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT 'Ͷ��Ա�ֻ�(����)',
  `postman_name` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'Ͷ��Ա����(����)',
  `company_id` bigint(20) DEFAULT NULL COMMENT 'Ͷ�ݹ�˾���(����)',
  `reminder_num` int(11) DEFAULT '0' COMMENT '�������',
  `send_num` int(10) DEFAULT '0' COMMENT '����ȡ�����Ŵ���',
  `app_send_num` int(10) DEFAULT '0' COMMENT 'app�û��ط�ȡ�������',
  `updater` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '����޸���',
  `expire_time` datetime DEFAULT NULL COMMENT '��������ʱ�� yyyy-MM-dd HH:mm:ss',
  `create_time` datetime DEFAULT NULL COMMENT '����ʱ��',
  `take_time` datetime DEFAULT NULL COMMENT 'ȡ��ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '����޸�ʱ��',
  `status` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '��ԤԼ-book,����-inbox,ȡ��-taken,�쳣-exceptional,��Ч-invalid\n,ԤԼȡ��-cancel',
  `delivery_time` datetime DEFAULT NULL COMMENT 'Ͷ��ʱ��',
  `cancel_book_time` datetime DEFAULT NULL COMMENT 'ȡ��ԤԼʱ��',
  `book_expire_time` datetime DEFAULT NULL COMMENT 'ԤԼ����ʱ��',
  `box_type` varchar(12) CHARACTER SET utf8 DEFAULT NULL COMMENT '�������',
  `channel_id` int(10) DEFAULT '0' COMMENT '����ID',
  `partner_cid` int(10) DEFAULT '0' COMMENT '������ID',
  `business_type` tinyint(3) NOT NULL DEFAULT '1' COMMENT 'ҵ������ 1��Ͷ�� 2���ļ� 3���ݴ�',
  `callback_url` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '�ص�URL',
  PRIMARY KEY (`id`),
  KEY `idx_sn` (`sn`),
  KEY `idx_create_time` (`create_time`),
  KEY `idx_channel_id` (`channel_id`) USING BTREE,
  KEY `idx_box_type` (`box_type`),
  KEY `idx_package_id` (`package_id`),
  KEY `idx_box_id` (`box_id`),
  KEY `idx_take_mobile` (`take_mobile`),
  KEY `idx_postman_uid` (`postman_uid`),
  KEY `idx_postman_mobile` (`postman_mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='������Ϣ';

CREATE TABLE `t_parcel_log` (
  `log_id` bigint(100) NOT NULL AUTO_INCREMENT COMMENT '����ID',
  `parcel_id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '����ID��eջ�����ɣ�ȫ��Ψһ',
  `package_id` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '�˵���(��ݹ�˾����)',
  `sn` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '�����ţ�ȫ��Ψһ',
  `box_id` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '���ID��ȫ��Ψһ',
  `take_code` varchar(36) COLLATE utf8_bin NOT NULL COMMENT 'ȡ����',
  `retrieve_code` varchar(36) COLLATE utf8_bin NOT NULL COMMENT '������(�ݲ����ֹ���Ա|���Ա����)',
  `code_expire_time` datetime NOT NULL COMMENT 'ԤԼ�롢ȡ���롢������ʧЧ��(ͬһ�������ɣ��ʿ���ͬʱʧЧ)',
  `take_uid` bigint(20) DEFAULT NULL COMMENT '�ռ���ID',
  `take_mobile` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT '�ռ����ֻ�(����)',
  `pickup_uid` bigint(20) DEFAULT NULL COMMENT 'ȡ����ID',
  `pickup_mobile` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT 'ȡ�����ֻ�(����)',
  `postman_uid` bigint(20) DEFAULT NULL COMMENT 'Ͷ��Ա���',
  `postman_mobile` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT 'Ͷ��Ա�ֻ�(����)',
  `postman_name` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'Ͷ��Ա����(����)',
  `company_id` bigint(20) DEFAULT NULL COMMENT 'Ͷ�ݹ�˾���(����)',
  `reminder_num` int(11) DEFAULT NULL COMMENT '�������',
  `send_num` int(10) DEFAULT NULL COMMENT '����ȡ�����Ŵ���',
  `app_send_num` int(10) DEFAULT NULL COMMENT 'app�û��ط�ȡ�������',
  `updater` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '����޸���',
  `updater_utype` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '�����°������û�����',
  `expire_time` datetime DEFAULT NULL COMMENT '����ʱ�� yyyy-MM-dd HH:mm:ss',
  `create_time` datetime DEFAULT NULL COMMENT '����ʱ��',
  `action_time` datetime DEFAULT NULL COMMENT 'ȡ��ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '����޸�ʱ��',
  `action` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '��������Ϊ��book-ԤԼ��putin-���룬take-ȡ�ߣ�set-ֱ�����ã�',
  `status` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '����״̬(��ԤԼ-book,����-inbox,ȡ��-taken,�쳣-exceptional,��Ч-invalid)',
  `book_type` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `channel_id` int(11) DEFAULT '0',
  `partner_cid` int(11) DEFAULT '0',
  `callback_url` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '�ص�URL',
  PRIMARY KEY (`log_id`),
  KEY `IDX_PARCEL_ID` (`parcel_id`),
  KEY `IDX_SN` (`sn`),
  KEY `IDX_BOX_ID` (`box_id`),
  KEY `IDX_PACKAGE_ID` (`package_id`),
  KEY `idx_take_mobile` (`take_mobile`),
  KEY `idx_postman_mobile` (`postman_mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='������־';

CREATE TABLE `t_partner` (
  `partner_id` int(10) NOT NULL COMMENT '������ID',
  `partner` varchar(60) COLLATE utf8_bin DEFAULT NULL COMMENT '������',
  `creator` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '������',
  `updater` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '����޸���',
  `update_time` datetime DEFAULT NULL COMMENT '�������ʱ��',
  `create_time` datetime DEFAULT NULL COMMENT '¼��ʱ��',
  `status` char(1) COLLATE utf8_bin DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  PRIMARY KEY (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='��������Ϣ��';

CREATE TABLE `t_supplier` (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '�豸��Ӧ��ID',
  `name` varchar(60) DEFAULT NULL COMMENT '����',
  `short_name` varchar(60) DEFAULT NULL COMMENT '���',
  `contact` varchar(60) DEFAULT NULL COMMENT '��ϵ��',
  `tel` varchar(20) DEFAULT NULL COMMENT '��ϵ�˵绰',
  `creator` varchar(32) DEFAULT NULL COMMENT '������',
  `updater` varchar(32) DEFAULT NULL COMMENT '����޸���',
  `create_time` datetime DEFAULT NULL COMMENT '����ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '����޸�ʱ��',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч',
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='�豸�ṩ�̱�';

CREATE TABLE `t_term` (
  `sn` varchar(20) NOT NULL COMMENT '�����������ţ�6λ�ʱ�+1λ��ĸ+3λ���ڱ��',
  `is_new` char(1) DEFAULT 'n' COMMENT '�Ƿ�Ǩ�Ƶ���ϵͳ��y-��Ǩ��;n-δǨ��',
  `did` bigint(20) DEFAULT '0' COMMENT '�ն���������ID',
  `dids` varchar(200) DEFAULT '0' COMMENT '�ն������༶����ID',
  `name` varchar(60) DEFAULT NULL COMMENT '��װ������',
  `term_type` varchar(60) DEFAULT NULL COMMENT '�ն�����',
  `supplier_id` int(11) DEFAULT '0' COMMENT '�豸��Ӧ��ID',
  `route_id` int(11) DEFAULT '0' COMMENT '·������Ӧ��ID',
  `network` varchar(20) DEFAULT '' COMMENT '��������',
  `ip` varchar(40) DEFAULT '' COMMENT 'IP��ַ',
  `mac` varchar(200) DEFAULT '' COMMENT 'MAC��ַ',
  `box_num` int(10) DEFAULT '0' COMMENT '�����',
  `rbox_num` int(10) DEFAULT '0' COMMENT '����״̬�����(����)',
  `app_version` varchar(20) DEFAULT '' COMMENT '����汾��',
  `province` varchar(620) DEFAULT '' COMMENT 'ʡ��/ֱϽ',
  `city_id` int(10) DEFAULT '0' COMMENT '������',
  `city` varchar(60) DEFAULT '' COMMENT '����(����)',
  `zone` varchar(60) DEFAULT '' COMMENT '����',
  `road` varchar(255) DEFAULT '' COMMENT '�ֵ�',
  `locate` varchar(255) DEFAULT '' COMMENT '��ϸ��ַ',
  `locate_type` varchar(10) DEFAULT '' COMMENT 'locate����',
  `remark` varchar(255) DEFAULT '' COMMENT '��ע',
  `zip` varchar(10) DEFAULT NULL COMMENT '�ʱ�',
  `lng` varchar(20) DEFAULT '0' COMMENT '��ͼ�ϵ�ά��',
  `lat` varchar(20) DEFAULT '0' COMMENT '��ͼ�ϵľ���',
  `manu_modify` char(1) DEFAULT 'n' COMMENT '�ֶ���������γ��',
  `create_time` datetime NOT NULL COMMENT '����ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '�������ʱ��',
  `use_time` datetime DEFAULT NULL COMMENT '(���һ��)��������',
  `status` varchar(10) DEFAULT 'run' COMMENT '״̬��run-����ʹ��; stop-ͣ��/δ����; testrun-������',
  `base_secret` varchar(20) DEFAULT NULL COMMENT '������Կ',
  `allocate_rule` varchar(10) NOT NULL DEFAULT 'random' COMMENT '����������asc-˳��ȡ��desc-����ȡ��random-���ȡ',
  PRIMARY KEY (`sn`),
  KEY `lng_index` (`lng`),
  KEY `lat_index` (`lat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�ն������¼��';

CREATE TABLE `t_term_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(20) DEFAULT NULL COMMENT '�ն˺�',
  `code` varchar(20) DEFAULT NULL COMMENT '��',
  `expire_time` datetime DEFAULT NULL COMMENT 'Ԥ��ʧЧʱ��',
  `create_time` datetime DEFAULT NULL COMMENT '����ʱ��',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `sn_index` (`sn`),
  KEY `code_index` (`code`),
  KEY `expire_time_index` (`expire_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_term_gps_log` (
  `sn` varchar(20) NOT NULL COMMENT '�ն˺�',
  `uid` varchar(20) NOT NULL COMMENT '�ɼ���UID(���Ի�Աϵͳ)',
  `mobile` varchar(20) NOT NULL COMMENT '�ɼ���mobile&��½�˺�(���Ի�Աϵͳ)',
  `lng` varchar(20) NOT NULL COMMENT '��ͼ�ϵ�γ��',
  `lat` varchar(20) NOT NULL COMMENT '��ͼ�ϵľ���',
  `device` varchar(60) DEFAULT '' COMMENT '�豸ID',
  `create_time` datetime NOT NULL COMMENT '����ʱ��',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '״̬��y-��Ч; n-��Ч'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�ɼ����ն�GPS��Ϣ';

CREATE TABLE `t_term_info` (
  `sn` varchar(20) NOT NULL COMMENT '������',
  `key` varchar(60) DEFAULT '0' COMMENT '����������ȫСд',
  `value` varchar(255) DEFAULT '' COMMENT '������ֵ',
  `update_time` datetime NOT NULL COMMENT '�������ʱ��',
  `create_time` datetime NOT NULL COMMENT '����ʱ��',
  UNIQUE KEY `sn` (`sn`,`key`),
  KEY `idx_sn` (`sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�ն˾�̬��Ϣ��';

CREATE TABLE `t_term_status` (
  `sn` varchar(20) NOT NULL COMMENT '������',
  `key` varchar(255) NOT NULL COMMENT '����-״̬��',
  `value` varchar(255) NOT NULL COMMENT '����-״ֵ̬',
  `update_time` datetime NOT NULL COMMENT '�������ʱ��'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�ն����㵱ǰ״̬��';

CREATE TABLE `t_term_status_history` (
  `sn` varchar(20) NOT NULL COMMENT '������',
  `key` varchar(255) NOT NULL COMMENT '����-״̬��',
  `value` varchar(255) NOT NULL COMMENT '����-״ֵ̬',
  `create_time` datetime NOT NULL COMMENT '��¼¼��ʱ��'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�ն�������ʷ״̬��';

CREATE TABLE `t_term_sync` (
  `sn` varchar(20) NOT NULL COMMENT '�����������ţ�6λ�ʱ�+1λ��ĸ+3λ���ڱ��',
  `is_new` char(1) DEFAULT 'n' COMMENT '�Ƿ�Ǩ�Ƶ���ϵͳ��y-��Ǩ��;n-δǨ��',
  `wn` varchar(20) DEFAULT '0' COMMENT '��װ����',
  `did` bigint(20) DEFAULT '0' COMMENT 'ID',
  `dids` varchar(200) DEFAULT '0' COMMENT '�ն������༶����ID',
  `name` varchar(60) DEFAULT NULL COMMENT '��װ������',
  `term_type` varchar(60) DEFAULT NULL COMMENT '�ն�����',
  `supplier_id` int(11) DEFAULT '0' COMMENT '�豸��Ӧ��ID',
  `route_id` int(11) DEFAULT '0' COMMENT '·������Ӧ��ID',
  `network` varchar(20) DEFAULT '' COMMENT '��������',
  `ip` varchar(40) DEFAULT '' COMMENT 'IP��ַ',
  `mac` varchar(40) DEFAULT '' COMMENT 'MAC��ַ',
  `box_num` int(10) DEFAULT '0' COMMENT '�����',
  `rbox_num` int(10) DEFAULT '0' COMMENT '����״̬�����(����)',
  `app_version` varchar(20) DEFAULT '' COMMENT '����汾��',
  `province` varchar(620) DEFAULT '' COMMENT 'ʡ��/ֱϽ',
  `city_id` int(10) DEFAULT '0' COMMENT '������',
  `city` varchar(60) DEFAULT '' COMMENT '����(����)',
  `zone` varchar(60) DEFAULT '' COMMENT '����',
  `road` varchar(255) DEFAULT '' COMMENT '�ֵ�',
  `locate` varchar(255) DEFAULT '' COMMENT '��ϸ��ַ',
  `locate_type` varchar(10) DEFAULT '' COMMENT 'locate����',
  `remark` varchar(255) DEFAULT '' COMMENT '��ע',
  `zip` varchar(10) DEFAULT NULL COMMENT '�ʱ�',
  `lng` varchar(20) DEFAULT '0' COMMENT '��ͼ�ϵ�ά��',
  `lat` varchar(20) DEFAULT '0' COMMENT '��ͼ�ϵľ���',
  `manu_modify` char(1) DEFAULT 'n' COMMENT '�ֶ���������γ��',
  `create_time` datetime NOT NULL COMMENT '����ʱ��',
  `update_time` datetime DEFAULT NULL COMMENT '�������ʱ��',
  `use_time` datetime DEFAULT NULL COMMENT '(���һ��)��������',
  `status` varchar(10) DEFAULT 'run' COMMENT '״̬��run-����ʹ��; stop-ͣ��/δ����; testrun-������',
  `base_secret` varchar(20) DEFAULT NULL COMMENT '������Կ',
  `allocate_rule` varchar(10) NOT NULL DEFAULT 'random' COMMENT '����������asc-˳��ȡ��desc-����ȡ��random-���ȡ',
  PRIMARY KEY (`sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�ն������¼��';
