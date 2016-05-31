--
-- Table structure for table `ocelot_freeleeches`
--

CREATE TABLE IF NOT EXISTS `ocelot_freeleeches` (
  `uid` int(11) unsigned NOT NULL,
  `tid` int(11) unsigned NOT NULL,
  `Time` datetime NOT NULL,
  `Expired` tinyint(1) NOT NULL DEFAULT '0',
  `Downloaded` bigint(20) NOT NULL DEFAULT '0',
  `Uses` int(10) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ocelot_peers`
--

CREATE TABLE IF NOT EXISTS `ocelot_peers` (
  `uid` int(11) unsigned NOT NULL,
  `tid` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `announced` int(11) NOT NULL DEFAULT '0',
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `downloaded` bigint(20) NOT NULL DEFAULT '0',
  `remaining` bigint(20) NOT NULL DEFAULT '0',
  `uploaded` bigint(20) NOT NULL DEFAULT '0',
  `upspeed` int(10) unsigned NOT NULL DEFAULT '0',
  `downspeed` int(10) unsigned NOT NULL DEFAULT '0',
  `corrupt` bigint(20) NOT NULL DEFAULT '0',
  `timespent` int(10) unsigned NOT NULL DEFAULT '0',
  `useragent` varchar(60) NOT NULL DEFAULT '',
  `connectable` tinyint(4) NOT NULL DEFAULT '1',
  `peer_id` binary(20) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `ip` varchar(53) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ocelot_snatches`
--

CREATE TABLE IF NOT EXISTS `ocelot_snatches` (
  `uid` int(11) unsigned NOT NULL,
  `tstamp` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `ip` varchar(53) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ocelot_torrents`
--

CREATE TABLE IF NOT EXISTS `ocelot_torrents` (
`tid` int(11) unsigned NOT NULL,
  `info_hash` blob,
  `Leechers` int(6) NOT NULL DEFAULT '0',
  `Seeders` int(6) NOT NULL DEFAULT '0',
  `last_action` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `FreeTorrent` enum('0','1','2') NOT NULL DEFAULT '0',
  `Snatched` int(10) unsigned NOT NULL DEFAULT '0',
  `balance` bigint(20) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ocelot_users`
--

CREATE TABLE IF NOT EXISTS `ocelot_users` (
`uid` int(11) unsigned NOT NULL,
  `Uploaded` bigint(20) unsigned NOT NULL DEFAULT '0',
  `Downloaded` bigint(20) unsigned NOT NULL DEFAULT '0',
  `Enabled` enum('0','1','2') NOT NULL DEFAULT '1',
  `IP` varchar(15) NOT NULL DEFAULT '0.0.0.0',
  `Visible` enum('1','0') NOT NULL DEFAULT '1',
  `can_leech` tinyint(4) NOT NULL DEFAULT '1',
  `torrent_pass` char(32) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ocelot_whitelist`
--

CREATE TABLE IF NOT EXISTS `ocelot_whitelist` (
`id` int(10) unsigned NOT NULL,
  `peer_id` varchar(20) DEFAULT NULL,
  `vstring` varchar(200) DEFAULT '',
  `note` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ocelot_freeleeches`
--
ALTER TABLE `ocelot_freeleeches`
 ADD PRIMARY KEY (`uid`,`tid`), ADD KEY `Time` (`Time`), ADD KEY `Expired_Time` (`Expired`,`Time`), ADD KEY `tid` (`tid`);

--
-- Indexes for table `ocelot_peers`
--
ALTER TABLE `ocelot_peers`
 ADD PRIMARY KEY (`uid`,`tid`,`peer_id`), ADD KEY `remaining_idx` (`remaining`), ADD KEY `mtime_idx` (`mtime`), ADD KEY `uid_active` (`uid`,`active`), ADD KEY `tid` (`tid`);

--
-- Indexes for table `ocelot_snatches`
--
ALTER TABLE `ocelot_snatches`
 ADD KEY `fid` (`tid`), ADD KEY `tstamp` (`tstamp`), ADD KEY `uid_tstamp` (`uid`,`tstamp`);

--
-- Indexes for table `ocelot_torrents`
--
ALTER TABLE `ocelot_torrents`
 ADD PRIMARY KEY (`tid`), ADD UNIQUE KEY `InfoHash` (`info_hash`(40)), ADD KEY `Seeders` (`Seeders`), ADD KEY `Leechers` (`Leechers`), ADD KEY `Snatched` (`Snatched`), ADD KEY `last_action` (`last_action`), ADD KEY `FreeTorrent` (`FreeTorrent`);

--
-- Indexes for table `ocelot_users`
--
ALTER TABLE `ocelot_users`
 ADD PRIMARY KEY (`uid`), ADD KEY `Uploaded` (`Uploaded`), ADD KEY `Downloaded` (`Downloaded`), ADD KEY `Enabled` (`Enabled`), ADD KEY `torrent_pass` (`torrent_pass`);

--
-- Indexes for table `ocelot_whitelist`
--
ALTER TABLE `ocelot_whitelist`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `peer_id` (`peer_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ocelot_torrents`
--
ALTER TABLE `ocelot_torrents`
MODIFY `tid` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ocelot_users`
--
ALTER TABLE `ocelot_users`
MODIFY `uid` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ocelot_whitelist`
--
ALTER TABLE `ocelot_whitelist`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `ocelot_freeleeches`
--
ALTER TABLE `ocelot_freeleeches`
ADD CONSTRAINT `ocelot_freeleeches_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `ocelot_users` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `ocelot_freeleeches_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `ocelot_torrents` (`tid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ocelot_peers`
--
ALTER TABLE `ocelot_peers`
ADD CONSTRAINT `ocelot_peers_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `ocelot_users` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `ocelot_peers_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `ocelot_torrents` (`tid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ocelot_snatches`
--
ALTER TABLE `ocelot_snatches`
ADD CONSTRAINT `ocelot_snatches_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `ocelot_users` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

