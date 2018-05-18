CREATE DATABASE IF NOT EXISTS db_ez DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci; 
USE db_ez;

CREATE TABLE `t_area` (
  `aid` int(10) NOT NULL AUTO_INCREMENT COMMENT '地区码',
  `name` varchar(100) DEFAULT NULL COMMENT '地区名称',
  `paid` varchar(80) DEFAULT NULL COMMENT '父地区码',
  `aids` varchar(200) DEFAULT NULL COMMENT '地区码全路径',
  `area_code` int(10) DEFAULT '0' COMMENT '固话区号',
  `zip` varchar(10) DEFAULT NULL COMMENT '邮编',
  `level` int(4) DEFAULT NULL COMMENT '网点级别',
  `sort_id` int(11) DEFAULT NULL COMMENT '同级显示用排序编码',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `status` char(1) DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='地区信息';

CREATE TABLE `t_book_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `package_id` varchar(40) DEFAULT NULL COMMENT '包裹号',
  `box_type` varchar(20) DEFAULT NULL COMMENT '箱格类型,big,small,etc',
  `book_type` varchar(45) DEFAULT NULL COMMENT '预约类型',
  `take_uid` bigint(20) DEFAULT NULL COMMENT '收件人ID',
  `take_mobile` varchar(15) DEFAULT NULL COMMENT '收件人手机',
  `postman_uid` bigint(20) DEFAULT NULL COMMENT '快递员ID',
  `postman_mobile` varchar(15) DEFAULT NULL COMMENT '快递员手机',
  `postman_name` varchar(50) DEFAULT NULL COMMENT '快递员姓名',
  `start_time` datetime DEFAULT NULL COMMENT '预约开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '预约结束时间',
  `book_time_span` int(11) DEFAULT NULL COMMENT '预约时长',
  `callback_url` varchar(256) DEFAULT NULL COMMENT '回调地址',
  `status` varchar(20) DEFAULT NULL COMMENT '状态，valid-有效，fail-失败，callback_fail-回调失败，success-成功,cancel-排队取消',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `sn` varchar(20) NOT NULL COMMENT '终端号',
  `parcel_id` varchar(100) NOT NULL COMMENT '包裹id',
  `company_id` bigint(20) DEFAULT NULL COMMENT '快递公司id',
  `box_id` varchar(40) DEFAULT NULL COMMENT '排队处理成功之后有boxId',
  `role` varchar(45) DEFAULT NULL  COMMENT '操作人角色',
  `updator` varchar(45) DEFAULT NULL  COMMENT '操作人手机号码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `idx_package_id` (`package_id`),
  KEY `idx_box_type` (`box_type`),
  KEY `idx_start_time` (`start_time`),
  KEY `idx_end_time` (`end_time`),
  KEY `idx_sn` (`sn`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_box` (
  `box_id` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '箱格ID，全局唯一，格式：sn+本格子在该柜上的序号',
  `sn` varchar(20) COLLATE utf8_bin DEFAULT '网点编号',
  `cabinet_id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '全局唯一编号，同资产管理ID',
  `box_type` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '箱格类型：如：大、中、小、主机',
  `box_type_id` int(10) DEFAULT '0' COMMENT '箱格详细类型ID，对应 t_box_type.box_type_id',
  `box_status` char(1) NOT NULL COLLATE utf8_bin DEFAULT 'r' COMMENT '箱格状态，如：r-正常运行中; e-故障中',
  `box_use_status` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '箱格使用状态，如:empty-空闲; reserved-预留; book-预约; used-占用',
  `layout_col` int(10) NOT NULL COMMENT '列号(定位箱格用)',
  `layout_row` int(10) NOT NULL COMMENT '行号(定位箱格用)',
  `layout_elect` int(10) NOT NULL COMMENT '锁控序号(映射箱格-锁控排线用，映射关系：行*列：锁控序号)',
  `update_time` datetime DEFAULT NULL COMMENT '最近更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '录入时间',
  `status` char(1) NOT NULL COLLATE utf8_bin DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  PRIMARY KEY (`box_id`),
  KEY `sn` (`sn`),
  KEY `cabinet_id` (`cabinet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='箱格信息表';

CREATE TABLE `t_box_layout` (
  `cabinet_type_id` int(11) NOT NULL COMMENT '柜型ID(内部生成)',
  `col` int(11) NOT NULL COMMENT '列数',
  `row` int(11) NOT NULL COMMENT '行数',
  `box_type` varchar(20) NOT NULL COMMENT '箱格规格类型：如：大、中、小、主机',
  `box_type_id` int(11) NOT NULL COMMENT '箱型详细规格ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='box布局关系表';

CREATE TABLE `t_box_sync` (
  `box_id` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '箱格ID，全局唯一，格式：sn+本格子在该柜上的序号',
  `sn` varchar(20) COLLATE utf8_bin DEFAULT '网点编号',
  `cabinet_id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '全局唯一编号，同资产管理ID',
  `box_type` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '箱格类型：如：大、中、小、主机',
  `box_type_id` int(10) DEFAULT '0' COMMENT '箱格详细类型ID，对应 t_box_type.box_type_id',
  `box_status` char(1) COLLATE utf8_bin DEFAULT 'r' COMMENT '箱格状态，如：r-正常运行中; e-故障中',
  `box_use_status` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '箱格使用状态，如:empty-空闲; reserved-预留; book-预约; used-占用',
  `layout_col` int(10) NOT NULL COMMENT '列号(定位箱格用)',
  `layout_row` int(10) NOT NULL COMMENT '行号(定位箱格用)',
  `layout_elect` int(10) NOT NULL COMMENT '锁控序号(映射箱格-锁控排线用，映射关系：行*列：锁控序号)',
  `update_time` datetime DEFAULT NULL COMMENT '最近更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '录入时间',
  `status` char(1) COLLATE utf8_bin DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  PRIMARY KEY (`box_id`),
  KEY `sn` (`sn`),
  KEY `cabinet_id` (`cabinet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='箱格信息表';

CREATE TABLE `t_box_type` (
  `box_type_id` int(11) NOT NULL COMMENT 'box详细规格ID(内部生成)',
  `name` varchar(50) DEFAULT NULL COMMENT '箱型规格名称',
  `box_type` varchar(20) NOT NULL COMMENT '箱格规格类型：如：大、中、小、主机',
  `width` varchar(5) DEFAULT NULL COMMENT '宽度(mm)',
  `height` varchar(5) DEFAULT NULL COMMENT '箱长度(mm)',
  `deep` varchar(5) DEFAULT NULL COMMENT '深度(mm)',
  `status` char(1) DEFAULT NULL COMMENT '状态，y-有效; n-无效',
  `creater` varchar(32) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(32) DEFAULT NULL COMMENT '最后修改人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`box_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='box详细规格表';

CREATE TABLE `t_cabinet` (
  `cabinet_id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '全局唯一编号，同资产管理ID',
  `serial_num` varchar(40) COLLATE utf8_bin DEFAULT '' COMMENT '出厂编号(供应商提供，可能重复)',
  `sn` varchar(20) COLLATE utf8_bin DEFAULT '0' COMMENT '网点编号，可为空(未分配给网点时)',
  `cabinet_type_id` int(11) NOT NULL COMMENT '柜型ID',
  `sort` int(11) DEFAULT '99' COMMENT '网点内柜子顺序号，从0开始，从左到右依次',
  `color` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '柜子颜色',
  `pos_phy` int(10) DEFAULT '0' COMMENT '物理位置序号(本网点唯一)',
  `pos_elect` int(10) DEFAULT '0' COMMENT '柜子锁控序号(本网点唯一)',
  `fuse_time` datetime DEFAULT NULL COMMENT '首次投入使用时间',
  `luse_time` datetime DEFAULT NULL COMMENT '最近投入使用时间(可多次投入使用)',
  `update_time` datetime DEFAULT NULL COMMENT '最近更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '录入时间',
  `status` varchar(10) COLLATE utf8_bin DEFAULT 'init' COMMENT '状态，init-初始化; testrun-试运营; run-运营中; breakdown-故障; abandon-废弃',
  PRIMARY KEY (`cabinet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='柜子信息表';

CREATE TABLE `t_cabinet_type` (
  `cabinet_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '柜型ID(内部生成)',
  `supplier_id` int(11) NOT NULL COMMENT '设备供应商ID',
  `cabinet_type` varchar(40) NOT NULL COMMENT '柜型类型(供应商提供，不排除不同供应商之间有相同称法)',
  `deep` int(11) NOT NULL COMMENT '柜子长度(单位：厘米)-以最长两点计',
  `width` int(11) NOT NULL COMMENT '柜子宽度(单位：厘米)-以最厚两点计',
  `height` int(11) NOT NULL COMMENT '柜子高度(单位：厘米)-以最高点计',
  `weight` int(11) NOT NULL COMMENT '柜子重量(单位：公斤)-非精确值',
  `use_type` int(4) NOT NULL COMMENT '柜子类型：0-主柜;1-副柜;2-快餐柜',
  `is_probe` char(1) NOT NULL DEFAULT 'n' COMMENT '是否有探测头，y-有效; n-无效',
  `in_out` varchar(5) DEFAULT NULL COMMENT '机型：in-室内机; out-室外机',
  `cbox_num` int(10) DEFAULT '0' COMMENT '箱格数',
  `layout` text COMMENT '箱格布局和规格(json) {列号:{行号:柜格类型, ...} ,...}; 柜格类型有[smallmiddleigsbigcomputer]',
  `note` text COMMENT '说明',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(32) DEFAULT NULL COMMENT '最后修改人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  PRIMARY KEY (`cabinet_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='设备提供商提供的cabinet类型表';

CREATE TABLE `t_channel` (
  `channel_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '业务渠道ID',
  `channel` varchar(60) DEFAULT NULL COMMENT '业务渠道',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(32) DEFAULT NULL COMMENT '最后修改人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  PRIMARY KEY (`channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='业务渠道表';

CREATE TABLE `t_city` (
  `city_id` int(10) NOT NULL COMMENT '城市ID，唯一标志',
  `city` varchar(50) NOT NULL COMMENT '城市名称',
  `province` varchar(20) NOT NULL COMMENT '省份名称(含直辖市)，不含省(市)字，如：广东、上海',
  `note` text COMMENT '简单的描述城市的信息，可空',
  `create_time` datetime NOT NULL COMMENT '城市信息提交时间',
  `status` char(1) DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  `zip_code` int(6) NOT NULL DEFAULT '0' COMMENT '邮编号码',
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='城市信息表';

CREATE TABLE `t_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `config_key` varchar(128) NOT NULL COMMENT '系统参数键',
  `config_value` varchar(128) NOT NULL COMMENT '系统参数值',
  `config_desc` varchar(256) NOT NULL COMMENT '系统参数描述',
  `config_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '配置类型，1-普通配置，2-开关配置',
  `is_global` char(1) NOT NULL DEFAULT 'y' COMMENT '状态，y-全局配置; n-局部配置(实际范围由下发时指定)',
  `creator` varchar(32) NOT NULL COMMENT '创建者',
  `updater` varchar(32) NOT NULL COMMENT '更新者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='终端配置表';

CREATE TABLE `t_config_biz_term` (
  `sn` varchar(20) NOT NULL COMMENT '网点编号',
  `datanode` varchar(30) DEFAULT '0' COMMENT 'Datanode 地址，格式： IP:Port',
  `creator` varchar(32) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='终端灰度配置表';

CREATE TABLE `t_config_blacklist` (
  `blacklist_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `type` varchar(20) NOT NULL COMMENT '配置类型，taker-取件人(手机号); pkg-运单(运单号)',
  `value` varchar(60) NOT NULL COMMENT 'type对应对象的值，当type=taker时：手机号; type=pkg时：运单号',
  `creator` varchar(32) NOT NULL COMMENT '创建者',
  `updater` varchar(32) NOT NULL COMMENT '更新者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  PRIMARY KEY (`blacklist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='黑名单配置表';

CREATE TABLE `t_config_launch` (
  `launch_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `config_id` int(11) unsigned NOT NULL COMMENT '配置ID',
  `bjob_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '批量任务ID',
  `config_key` varchar(128) NOT NULL COMMENT '配置名称',
  `config_value` varchar(128) NOT NULL COMMENT '配置值',
  `config_desc` varchar(256) NOT NULL COMMENT '配置描述',
  `config_type` tinyint(1) NOT NULL COMMENT '配置类型',
  `creator` varchar(32) NOT NULL COMMENT '创建者',
  `updater` varchar(32) NOT NULL COMMENT '更新者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  PRIMARY KEY (`launch_id`),
  KEY `config_id` (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='终端配置下发表';

CREATE TABLE `t_config_launch_term` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sn` varchar(36) NOT NULL COMMENT '终端编号',
  `config_id` int(11) unsigned NOT NULL COMMENT '配置ID',
  `launch_id` int(11) unsigned NOT NULL COMMENT '下发ID',
  `launch_status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '下发状态，1-未下发，2-下发失败，3-下发成功',
  `launch_time` datetime DEFAULT NULL COMMENT '下发时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  PRIMARY KEY (`id`),
  KEY `sn` (`sn`),
  KEY `config_id` (`config_id`),
  KEY `launch_id` (`launch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='终端配置下发终端列表';

CREATE TABLE `t_department` (
  `did` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '网点编号',
  `dids` varchar(200) DEFAULT NULL COMMENT '网点全路径',
  `dname` varchar(80) DEFAULT NULL COMMENT '网点名称',
  `area_id` varchar(200) DEFAULT NULL COMMENT '所属地区',
  `address` varchar(100) DEFAULT NULL COMMENT '详细地址',
  `zip` varchar(10) DEFAULT NULL COMMENT '邮编',
  `parent_id` varchar(20) DEFAULT NULL COMMENT '父级网点',
  `level` varchar(3) DEFAULT NULL COMMENT '网点级别',
  `sort_id` int(11) DEFAULT NULL COMMENT '同级显示用排序编码',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(32) DEFAULT NULL COMMENT '最后修改人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `contact_person` varchar(60) DEFAULT NULL COMMENT '联系人',
  `contact_tel` varchar(20) DEFAULT NULL COMMENT '联系人电话',
  `status` char(1) DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  PRIMARY KEY (`did`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='运营网点信息';

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
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '快递公司名',
  `status` tinyint(2) DEFAULT '1' COMMENT '合作状态：1 正常 0 终止',
  `add_time` datetime DEFAULT NULL,
  `add_user` varchar(32) NOT NULL DEFAULT '' COMMENT '添加人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='快递公司信息表';

CREATE TABLE `t_external_device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `external_device_id` varchar(32) DEFAULT NULL COMMENT '外设id',
  `external_device_type` varchar(32) DEFAULT NULL COMMENT '外设类型',
  `com_port_no` int(11) DEFAULT NULL COMMENT '外设对应的COM',
  `adapter_class` text COMMENT '适配的类',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  `sn` varchar(20) NOT NULL COMMENT '主键，网点编号，6位邮编+1位字母+3位区内编号',
  PRIMARY KEY (`id`),
  KEY `external_device_id_index` (`external_device_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='外设表';

CREATE TABLE `t_ez_app` (
  `app_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `type` varchar(20) DEFAULT NULL COMMENT '应用类型：termiosandriod',
  `note` text COMMENT '应用说明',
  `creator` varchar(32) DEFAULT NULL,
  `updater` varchar(32) DEFAULT NULL COMMENT '最后更新人',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '最后更新日期',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  PRIMARY KEY (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='应用程序主表';

CREATE TABLE `t_ez_app_launch` (
  `launch_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `vid` int(11) unsigned NOT NULL COMMENT '版本ID',
  `bjob_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '批量任务ID',
  `launch_type` tinyint(3) unsigned NOT NULL COMMENT '下发类型',
  `version` varchar(32) NOT NULL COMMENT '版本号',
  `update_file` varchar(32) NOT NULL DEFAULT '' COMMENT '更新文件ID',
  `desc_file` varchar(32) NOT NULL DEFAULT '' COMMENT '描述文件ID',
  `creator` varchar(32) NOT NULL COMMENT '创建者',
  `updater` varchar(32) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  PRIMARY KEY (`launch_id`),
  KEY `vid` (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='版本下发记录表';

CREATE TABLE `t_ez_app_launch_term` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sn` varchar(36) NOT NULL COMMENT '终端编号',
  `vid` int(11) unsigned NOT NULL COMMENT '版本ID',
  `launch_id` int(11) unsigned NOT NULL COMMENT '下发ID',
  `launch_type` tinyint(3) unsigned NOT NULL COMMENT '下发类型',
  `launch_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '下发状态，1-未下发，2-下发失败，3-下发成功，4-下载失败，5-下载成功，6-安装失败，7-安装成功',
  `launch_time` datetime DEFAULT NULL COMMENT '下发时间',
  `download_time` datetime DEFAULT NULL COMMENT '下载时间',
  `install_time` datetime DEFAULT NULL COMMENT '安装时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  PRIMARY KEY (`id`),
  KEY `sn` (`sn`),
  KEY `vid` (`vid`),
  KEY `launch_id` (`launch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='版本下发终端列表';

CREATE TABLE `t_ez_app_version` (
  `vid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '版本编号',
  `app_id` int(10) DEFAULT '0' COMMENT '所属应用ID',
  `version` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '版本号',
  `md5` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '应用文件MD5值',
  `iurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '应用文件内部下载地址/本地路径',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '应用文件外部下载地址(外网链接/CDN)',
  `updater` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '最后更新人',
  `update_time` datetime DEFAULT NULL COMMENT '最后更新日期',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  `creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `update_file` varchar(32) NOT NULL DEFAULT '' COMMENT '更新文件ID',
  `desc_file` varchar(32) NOT NULL DEFAULT '' COMMENT '描述文件ID',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `version` (`version`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='终端应用版本主表';

CREATE TABLE `t_ez_upload_file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` varchar(32) NOT NULL COMMENT '文件ID/文件名',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  `cate` tinyint(1) unsigned NOT NULL COMMENT '文件类别',
  `md5` varchar(64) NOT NULL COMMENT '文件MD5',
  `name` varchar(64) NOT NULL COMMENT '文件原始名称',
  `ext` varchar(8) NOT NULL COMMENT '扩展名',
  `size` int(11) unsigned NOT NULL COMMENT '文件大小，单位字节',
  `creator` varchar(32) NOT NULL COMMENT '创建者',
  `updater` varchar(32) NOT NULL COMMENT '更新者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `file_id` (`file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='E栈管理后台上传文件表';

CREATE TABLE `t_notify_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `type` varchar(20) NOT NULL COMMENT '通知类型：取件码-take;逾期通知-expire;催领-urge;etc',
  `channel` varchar(20) NOT NULL COMMENT '通知渠道：短信-sms;微信-wechat;B端APP-app_biz;C端App-app_cuz;管理员App-app_opt;',
  `rid` varchar(60) DEFAULT '0' COMMENT '关联对象ID：包裹-parcel_id; etc',
  `tpl_code` varchar(30) DEFAULT 'null' COMMENT '通知模板code，若无则为空',
  `msg` varchar(256) NOT NULL COMMENT '通知内容，或至少是模板中的变量',
  `toid` varchar(60) NOT NULL COMMENT '通知对象，根据channel定：sms-手机号; wechat-openid(不区分公众号); app_xxx-用户uid(认为所有类型用户使用同一套uid)',
  `note` varchar(60) DEFAULT NULL COMMENT '通知说明',
  `ret` tinyint(1) DEFAULT '0' COMMENT '通知结果：1-成功;0-失败',
  `creator` varchar(32) DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='通知记录表';

CREATE TABLE `t_opt_term` (
  `uid` varchar(20) NOT NULL COMMENT '运维人员UID(来自会员系统)',
  `mobile` varchar(20) NOT NULL COMMENT '运维人员mobile&登陆账号(来自会员系统)',
  `name` varchar(60) DEFAULT '' COMMENT '运维人员名字(来自会员系统)',
  `did` varchar(20) NOT NULL DEFAULT '' COMMENT '运营网点编号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `dids` varchar(80) NOT NULL DEFAULT '' COMMENT '运营网点层级关系',
  KEY `idx_sn_mobile` (`mobile`),
  KEY `idx_did` (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='终端 -运维人员对应关系表';


CREATE TABLE `t_parcel` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '包裹ID，e栈自生成，全局唯一',
  `package_id` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '运单号(快递公司产生)',
  `sn` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '网点编号，全局唯一',
  `box_id` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '箱格ID，全局唯一',
  `book_type` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '预约类型',
  `take_code` varchar(36) COLLATE utf8_bin NOT NULL COMMENT '取件码',
  `retrieve_code` varchar(36) COLLATE utf8_bin NOT NULL COMMENT '回收码(暂不区分管理员|快递员回收)',
  `code_expire_time` datetime NOT NULL COMMENT '预约码、取件码、回收码失效期(同一批次生成，故可以同时失效)',
  `take_uid` bigint(20) DEFAULT NULL COMMENT '收件人ID',
  `take_mobile` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT '收件人手机(冗余)',
  `pickup_uid` bigint(20) DEFAULT NULL COMMENT '取件人ID',
  `pickup_mobile` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT '取件人手机(冗余)',
  `postman_uid` bigint(20) DEFAULT NULL COMMENT '投递员编号',
  `postman_mobile` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT '投递员手机(冗余)',
  `postman_name` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '投递员姓名(冗余)',
  `company_id` bigint(20) DEFAULT NULL COMMENT '投递公司编号(冗余)',
  `reminder_num` int(11) DEFAULT '0' COMMENT '催领次数',
  `send_num` int(10) DEFAULT '0' COMMENT '发送取件短信次数',
  `app_send_num` int(10) DEFAULT '0' COMMENT 'app用户重发取件码次数',
  `updater` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '最后修改人',
  `expire_time` datetime DEFAULT NULL COMMENT '包裹过期时间 yyyy-MM-dd HH:mm:ss',
  `create_time` datetime DEFAULT NULL COMMENT '存入时间',
  `take_time` datetime DEFAULT NULL COMMENT '取件时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `status` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '已预约-book,在箱-inbox,取走-taken,异常-exceptional,无效-invalid\n,预约取消-cancel',
  `delivery_time` datetime DEFAULT NULL COMMENT '投件时间',
  `cancel_book_time` datetime DEFAULT NULL COMMENT '取消预约时间',
  `book_expire_time` datetime DEFAULT NULL COMMENT '预约过期时间',
  `box_type` varchar(12) CHARACTER SET utf8 DEFAULT NULL COMMENT '箱格类型',
  `channel_id` int(10) DEFAULT '0' COMMENT '渠道ID',
  `partner_cid` int(10) DEFAULT '0' COMMENT '合作商ID',
  `business_type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '业务类型 1：投递 2：寄件 3：暂存',
  `callback_url` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '回调URL',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='包裹信息';

CREATE TABLE `t_parcel_log` (
  `log_id` bigint(100) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `parcel_id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '包裹ID，e栈自生成，全局唯一',
  `package_id` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '运单号(快递公司产生)',
  `sn` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '网点编号，全局唯一',
  `box_id` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '箱格ID，全局唯一',
  `take_code` varchar(36) COLLATE utf8_bin NOT NULL COMMENT '取件码',
  `retrieve_code` varchar(36) COLLATE utf8_bin NOT NULL COMMENT '回收码(暂不区分管理员|快递员回收)',
  `code_expire_time` datetime NOT NULL COMMENT '预约码、取件码、回收码失效期(同一批次生成，故可以同时失效)',
  `take_uid` bigint(20) DEFAULT NULL COMMENT '收件人ID',
  `take_mobile` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT '收件人手机(冗余)',
  `pickup_uid` bigint(20) DEFAULT NULL COMMENT '取件人ID',
  `pickup_mobile` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT '取件人手机(冗余)',
  `postman_uid` bigint(20) DEFAULT NULL COMMENT '投递员编号',
  `postman_mobile` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT '投递员手机(冗余)',
  `postman_name` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '投递员姓名(冗余)',
  `company_id` bigint(20) DEFAULT NULL COMMENT '投递公司编号(冗余)',
  `reminder_num` int(11) DEFAULT NULL COMMENT '催领次数',
  `send_num` int(10) DEFAULT NULL COMMENT '发送取件短信次数',
  `app_send_num` int(10) DEFAULT NULL COMMENT 'app用户重发取件码次数',
  `updater` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '最后修改人',
  `updater_utype` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '最后更新包裹的用户类型',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间 yyyy-MM-dd HH:mm:ss',
  `create_time` datetime DEFAULT NULL COMMENT '存入时间',
  `action_time` datetime DEFAULT NULL COMMENT '取件时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `action` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '操作的行为（book-预约，putin-放入，take-取走，set-直接设置）',
  `status` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '包裹状态(已预约-book,在箱-inbox,取走-taken,异常-exceptional,无效-invalid)',
  `book_type` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `channel_id` int(11) DEFAULT '0',
  `partner_cid` int(11) DEFAULT '0',
  `callback_url` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '回调URL',
  PRIMARY KEY (`log_id`),
  KEY `IDX_PARCEL_ID` (`parcel_id`),
  KEY `IDX_SN` (`sn`),
  KEY `IDX_BOX_ID` (`box_id`),
  KEY `IDX_PACKAGE_ID` (`package_id`),
  KEY `idx_take_mobile` (`take_mobile`),
  KEY `idx_postman_mobile` (`postman_mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='包裹日志';

CREATE TABLE `t_partner` (
  `partner_id` int(10) NOT NULL COMMENT '合作方ID',
  `partner` varchar(60) COLLATE utf8_bin DEFAULT NULL COMMENT '合作方',
  `creator` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `updater` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '最后修改人',
  `update_time` datetime DEFAULT NULL COMMENT '最近更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '录入时间',
  `status` char(1) COLLATE utf8_bin DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  PRIMARY KEY (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='合作方信息表';

CREATE TABLE `t_supplier` (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '设备供应商ID',
  `name` varchar(60) DEFAULT NULL COMMENT '名称',
  `short_name` varchar(60) DEFAULT NULL COMMENT '简称',
  `contact` varchar(60) DEFAULT NULL COMMENT '联系人',
  `tel` varchar(20) DEFAULT NULL COMMENT '联系人电话',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(32) DEFAULT NULL COMMENT '最后修改人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '状态，y-有效; n-无效',
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='设备提供商表';

CREATE TABLE `t_term` (
  `sn` varchar(20) NOT NULL COMMENT '主键，网点编号，6位邮编+1位字母+3位区内编号',
  `is_new` char(1) DEFAULT 'n' COMMENT '是否迁移到新系统：y-已迁移;n-未迁移',
  `did` bigint(20) DEFAULT '0' COMMENT '终端所属网点ID',
  `dids` varchar(200) DEFAULT '0' COMMENT '终端所属多级网点ID',
  `name` varchar(60) DEFAULT NULL COMMENT '安装点名称',
  `term_type` varchar(60) DEFAULT NULL COMMENT '终端类型',
  `supplier_id` int(11) DEFAULT '0' COMMENT '设备供应商ID',
  `route_id` int(11) DEFAULT '0' COMMENT '路由器供应商ID',
  `network` varchar(20) DEFAULT '' COMMENT '网络类型',
  `ip` varchar(40) DEFAULT '' COMMENT 'IP地址',
  `mac` varchar(200) DEFAULT '' COMMENT 'MAC地址',
  `box_num` int(10) DEFAULT '0' COMMENT '箱格数',
  `rbox_num` int(10) DEFAULT '0' COMMENT '正常状态箱格数(冗余)',
  `app_version` varchar(20) DEFAULT '' COMMENT '软件版本号',
  `province` varchar(620) DEFAULT '' COMMENT '省份/直辖',
  `city_id` int(10) DEFAULT '0' COMMENT '城市码',
  `city` varchar(60) DEFAULT '' COMMENT '城市(冗余)',
  `zone` varchar(60) DEFAULT '' COMMENT '区域',
  `road` varchar(255) DEFAULT '' COMMENT '街道',
  `locate` varchar(255) DEFAULT '' COMMENT '详细地址',
  `locate_type` varchar(10) DEFAULT '' COMMENT 'locate类型',
  `remark` varchar(255) DEFAULT '' COMMENT '备注',
  `zip` varchar(10) DEFAULT NULL COMMENT '邮编',
  `lng` varchar(20) DEFAULT '0' COMMENT '地图上的维度',
  `lat` varchar(20) DEFAULT '0' COMMENT '地图上的经度',
  `manu_modify` char(1) DEFAULT 'n' COMMENT '手动修正过经纬度',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最近更新时间',
  `use_time` datetime DEFAULT NULL COMMENT '(最近一次)启用日期',
  `status` varchar(10) DEFAULT 'run' COMMENT '状态，run-正常使用; stop-停用/未启用; testrun-试运行',
  `base_secret` varchar(20) DEFAULT NULL COMMENT '基础密钥',
  `allocate_rule` varchar(10) NOT NULL DEFAULT 'random' COMMENT '分配箱格规则，asc-顺序取，desc-倒序取，random-随机取',
  PRIMARY KEY (`sn`),
  KEY `lng_index` (`lng`),
  KEY `lat_index` (`lat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='终端网点记录表';

CREATE TABLE `t_term_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(20) DEFAULT NULL COMMENT '终端号',
  `code` varchar(20) DEFAULT NULL COMMENT '码',
  `expire_time` datetime DEFAULT NULL COMMENT '预计失效时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `sn_index` (`sn`),
  KEY `code_index` (`code`),
  KEY `expire_time_index` (`expire_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `t_term_gps_log` (
  `sn` varchar(20) NOT NULL COMMENT '终端号',
  `uid` varchar(20) NOT NULL COMMENT '采集人UID(来自会员系统)',
  `mobile` varchar(20) NOT NULL COMMENT '采集人mobile&登陆账号(来自会员系统)',
  `lng` varchar(20) NOT NULL COMMENT '地图上的纬度',
  `lat` varchar(20) NOT NULL COMMENT '地图上的经度',
  `device` varchar(60) DEFAULT '' COMMENT '设备ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status` char(1) NOT NULL DEFAULT 'y' COMMENT '状态，y-有效; n-无效'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采集的终端GPS信息';

CREATE TABLE `t_term_info` (
  `sn` varchar(20) NOT NULL COMMENT '网点编号',
  `key` varchar(60) DEFAULT '0' COMMENT '配置项名，全小写',
  `value` varchar(255) DEFAULT '' COMMENT '配置项值',
  `update_time` datetime NOT NULL COMMENT '最近更新时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  UNIQUE KEY `sn` (`sn`,`key`),
  KEY `idx_sn` (`sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='终端静态信息表';

CREATE TABLE `t_term_status` (
  `sn` varchar(20) NOT NULL COMMENT '网点编号',
  `key` varchar(255) NOT NULL COMMENT '网点-状态项',
  `value` varchar(255) NOT NULL COMMENT '网点-状态值',
  `update_time` datetime NOT NULL COMMENT '最近更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='终端网点当前状态表';

CREATE TABLE `t_term_status_history` (
  `sn` varchar(20) NOT NULL COMMENT '网点编号',
  `key` varchar(255) NOT NULL COMMENT '网点-状态项',
  `value` varchar(255) NOT NULL COMMENT '网点-状态值',
  `create_time` datetime NOT NULL COMMENT '记录录入时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='终端网点历史状态表';

CREATE TABLE `t_term_sync` (
  `sn` varchar(20) NOT NULL COMMENT '主键，网点编号，6位邮编+1位字母+3位区内编号',
  `is_new` char(1) DEFAULT 'n' COMMENT '是否迁移到新系统：y-已迁移;n-未迁移',
  `wn` varchar(20) DEFAULT '0' COMMENT '安装点编号',
  `did` bigint(20) DEFAULT '0' COMMENT 'ID',
  `dids` varchar(200) DEFAULT '0' COMMENT '终端所属多级网点ID',
  `name` varchar(60) DEFAULT NULL COMMENT '安装点名称',
  `term_type` varchar(60) DEFAULT NULL COMMENT '终端类型',
  `supplier_id` int(11) DEFAULT '0' COMMENT '设备供应商ID',
  `route_id` int(11) DEFAULT '0' COMMENT '路由器供应商ID',
  `network` varchar(20) DEFAULT '' COMMENT '网络类型',
  `ip` varchar(40) DEFAULT '' COMMENT 'IP地址',
  `mac` varchar(40) DEFAULT '' COMMENT 'MAC地址',
  `box_num` int(10) DEFAULT '0' COMMENT '箱格数',
  `rbox_num` int(10) DEFAULT '0' COMMENT '正常状态箱格数(冗余)',
  `app_version` varchar(20) DEFAULT '' COMMENT '软件版本号',
  `province` varchar(620) DEFAULT '' COMMENT '省份/直辖',
  `city_id` int(10) DEFAULT '0' COMMENT '城市码',
  `city` varchar(60) DEFAULT '' COMMENT '城市(冗余)',
  `zone` varchar(60) DEFAULT '' COMMENT '区域',
  `road` varchar(255) DEFAULT '' COMMENT '街道',
  `locate` varchar(255) DEFAULT '' COMMENT '详细地址',
  `locate_type` varchar(10) DEFAULT '' COMMENT 'locate类型',
  `remark` varchar(255) DEFAULT '' COMMENT '备注',
  `zip` varchar(10) DEFAULT NULL COMMENT '邮编',
  `lng` varchar(20) DEFAULT '0' COMMENT '地图上的维度',
  `lat` varchar(20) DEFAULT '0' COMMENT '地图上的经度',
  `manu_modify` char(1) DEFAULT 'n' COMMENT '手动修正过经纬度',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最近更新时间',
  `use_time` datetime DEFAULT NULL COMMENT '(最近一次)启用日期',
  `status` varchar(10) DEFAULT 'run' COMMENT '状态，run-正常使用; stop-停用/未启用; testrun-试运行',
  `base_secret` varchar(20) DEFAULT NULL COMMENT '基础密钥',
  `allocate_rule` varchar(10) NOT NULL DEFAULT 'random' COMMENT '分配箱格规则，asc-顺序取，desc-倒序取，random-随机取',
  PRIMARY KEY (`sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='终端网点记录表';
