--
-- (C) 2013-18 - ntop.org
--

local sonicwall = {}

-- ################################################################################

local type_map = {
   ["1"] = "TIME_STAMP",
   ["2"] = "FLOW_IDENTIFIER",
   ["3"] = "INITIATOR_GW_MAC",
   ["4"] = "RESPONDER_GW_MAC",
   ["5"] = "INITIATOR_IP_ADDR",
   ["6"] = "RESPONDER_IP_ADDR",
   ["7"] = "INITIATOR_GW_IP_ADDR",
   ["8"] = "RESPONDER_GW_IP_ADDR",
   ["9"] = "INITIATOR_IFACE",
   ["10"] = "RESPONDER_IFACE",
   ["11"] = "INITIATOR_PORT",
   ["12"] = "RESPONDER_PORT",
   ["13"] = "INIT_TO_RESP_PKTS",
   ["14"] = "INIT_TO_RESP_OCTETS",
   ["15"] = "RESP_TO_INIT_PKTS",
   ["16"] = "RESP_TO_INIT_OCTETS",
   ["17"] = "FLOW_START_TIME",
   ["18"] = "FLOW_END_TIME",
   ["19"] = "INTERNAL_FLAGS",
   ["20"] = "PROTOCOL_TYPE",
   ["22"] = "FLOW_TO_APPLICATION_ID",
   ["23"] = "FLOW_TO_USER_ID",
   ["25"] = "FLOW_TO_IPS_ID",
   ["26"] = "FLOW_TO_VIRUS_ID",
   ["27"] = "FLOW_TO_SPYWARE_ID",
   ["28"] = "TEMPLATE_IDENTIFIER",
   ["29"] = "TABLE_NAME",
   ["30"] = "COLUMN_IDENTIFIER",
   ["31"] = "COLUMN_NAME",
   ["32"] = "COLUMN_TYPE",
   ["33"] = "COLUMN_STANDARD_IPFIX_ID",
   ["34"] = "SONIC_USER_INDEX",
   ["35"] = "SONIC_USER_NAME",
   ["36"] = "SONIC_USER_ID",
   ["38"] = "USER_AUTH_TYPE",
   ["39"] = "APP_INDEX",
   ["40"] = "APP_ID",
   ["41"] = "APP_NAME",
   ["42"] = "APP_CAT_ID",
   ["43"] = "APP_CAT_NAME",
   ["44"] = "APP_SIG_ID",
   ["45"] = "GAV_INDEX",
   ["46"] = "GAV_NAME",
   ["47"] = "GAV_SIG_ID",
   ["48"] = "IPS_INDEX",
   ["49"] = "IPS_NAME",
   ["50"] = "IPS_CAT_ID",
   ["51"] = "IPS_CAT_NAME",
   ["52"] = "IPS_SIG_ID",
   ["53"] = "ASPY_INDEX",
   ["54"] = "ASPY_NAME",
   ["55"] = "ASPY_PROD_ID",
   ["56"] = "ASPY_PROD_NAME",
   ["57"] = "ASPY_SIG_ID",
   ["59"] = "URL_NAME",
   ["60"] = "URL_IP",
   ["62"] = "RATING_INDEX",
   ["63"] = "RATING_NAME",
   ["64"] = "REGION_ID",
   ["65"] = "COUNTRY_ID",
   ["66"] = "COUNTRY_NAME",
   ["67"] = "REGION_NAME",
   ["68"] = "LOCATION_IP",
   ["69"] = "LOCATION_REGION_ID",
   ["70"] = "LOCATION_DOMAIN_NAME",
   ["101"] = "IF_STAT_IFACE",
   ["102"] = "IF_STAT_IN_PKTS_RATE",
   ["103"] = "IF_STAT_OUT_PKTS_RATE",
   ["104"] = "IF_STAT_IN_OCTETS_RATE",
   ["105"] = "IF_STAT_OUT_OCTETS_RATE",
   ["106"] = "IF_STAT_IN_PKT_SIZE",
   ["107"] = "IF_STAT_OUT_PKT_SIZE",
   ["108"] = "IF_STAT_CONN_RATE",
   ["111"] = "FLOW_INIT_OCTETS_RATE",
   ["112"] = "FLOW_RESP_OCTETS_RATE",
   ["113"] = "FLOW_INIT_PKT_RATE",
   ["114"] = "FLOW_RESP_PKT_RATE",
   ["115"] = "FLOW_INIT_PKT_SIZE",
   ["116"] = "FLOW_RESP_PKT_SIZE",
   ["117"] = "IF_STAT_IF_NAME",
   ["118"] = "IF_STAT_IF_TYPE",
   ["119"] = "IF_STAT_IF_SPEED",
   ["120"] = "IF_STAT_IF_STATE",
   ["121"] = "IF_STAT_IF_MTU",
   ["122"] = "IF_STAT_IF_MODE",
   ["123"] = "URL_FLOW_ID",
   ["124"] = "URL_TIME_ID",
   ["126"] = "CORE_STAT_CORE_ID",
   ["127"] = "CORE_STAT_CORE_UTIL",
   ["128"] = "VOIP_FLOW_ID",
   ["130"] = "VOIP_INIT_CALL_ID",
   ["131"] = "VOIP_RESP_CALL_ID",
   ["132"] = "MEDIA_TYPE",
   ["133"] = "MEDIA_PROTOCOL",
   ["134"] = "SERVICE_NAME",
   ["135"] = "SERVICE_IP_TYPE",
   ["136"] = "SERVICE_PORT_BEGIN",
   ["137"] = "SERVICE_PORT_END",
   ["138"] = "SPAM_SESS_ID",
   ["139"] = "SPAM_FLOW_ID",
   ["140"] = "SPAM_TIME_ID",
   ["141"] = "SPAM_SPAMMER",
   ["142"] = "SPAM_TYPE",
   ["143"] = "SPAM_TO_E_MAIL",
   ["144"] = "SPAM_FROM_E_MAIL",
   ["145"] = "MEM_TOTAL_RAM",
   ["146"] = "MEM_AVAIL_RAM",
   ["147"] = "MEM_USED_RAM",
   ["148"] = "MEM_DB_RAM",
   ["149"] = "MEM_FLOW_COUNT",
   ["150"] = "MEM_PER_FLOW",
   ["151"] = "DEV_IFACE_ID",
   ["152"] = "DEV_IP_ADDR",
   ["153"] = "DEV_MAC_ADDR",
   ["154"] = "DEV_NAME",
   ["155"] = "VPN_IN_SPI_ID",
   ["156"] = "VPN_OUT_SPI_ID",
   ["157"] = "VPN_TUNNEL_NAME",
   ["158"] = "VPN_LOCAL_GW",
   ["159"] = "VPN_REMOTE_GW",
   ["160"] = "VPN_TUNNEL_IFACE_ID",
   ["161"] = "VPN_POLICY_TYPE",
   ["162"] = "VPN_PROTOCOL_TYPE",
   ["163"] = "VPN_ENCRYPTION_TYPE",
   ["164"] = "VPN_AUTHENTICATION_TYPE",
   ["165"] = "VPN_START_TIME",
   ["166"] = "VPN_END_TIME",
   ["167"] = "INIT_VPN_SPI_OUT",
   ["168"] = "RESP_VPN_SPI_OUT",
   ["169"] = "INIT_TO_RESP_DELTA_PKTS",
   ["170"] = "INIT_TO_RESP_DELTA_OCTETS",
   ["171"] = "RESP_TO_INIT_DELTA_PKTS",
   ["172"] = "RESP_TO_INIT_DELTA_OCTETS",
   ["173"] = "FLOW_BLOCK_REASON",
   ["174"] = "IF_STAT_MAC_ADDRESS",
   ["175"] = "IF_STAT_IP_ADDRESS",
   ["176"] = "IF_STAT_SECURITY_TYPE",
   ["177"] = "IF_STAT_ZONE_NAME",
   ["178"] = "USER_IP_ADDR",
   ["179"] = "URL_RATING_VAL1",
   ["180"] = "URL_RATING_VAL2",
   ["181"] = "URL_RATING_VAL3",
   ["182"] = "URL_RATING_VAL4",
   ["183"] = "APP_BWM_ATTR",
   ["184"] = "VOIP_INIT2RESP_LOST_PKTS",
   ["185"] = "VOIP_RESP2INIT_LOST_PKTS",
   ["186"] = "VOIP_INIT2RESP_AVG_LATENCY",
   ["187"] = "VOIP_INIT2RESP_MAX_LATENCY",
   ["188"] = "VOIP_RESP2INIT_AVG_LATENCY",
   ["189"] = "VOIP_RESP2INIT_MAX_LATENCY",
   ["190"] = "APP_CONTENT_TYPE",
   ["191"] = "SNWL_OPTION",
   ["192"] = "APP_RISK_ATTR",
   ["193"] = "APP_TECH_ATTR",
   ["194"] = "APP_ATTR_BIT_MASK",
   ["195"] = "TOP_APPS_SIGID",
   ["196"] = "TOP_APPS_APPNAME",
   ["197"] = "TOP_APPS_RATE",
}

local type_value_map = {
   ["22"] = { -- EField = 22, Field bytes = 4, EntId = 8741, type = unsigned int-32bits, name=flow to application id
      ["1"] = "Skype",
      ["3"] = "Winny",
      ["4"] = "eMule",
      ["5"] = "Encrypted Key Exchange",
      ["6"] = "Non-SSL traffic over SSL port",
      ["7"] = "Encrypted Key Exchange",
      ["58"] = "Flash Video (FLV)",
      ["59"] = "Flash Video (FLV)",
      ["63"] = "BitTorrent Protocol",
      ["66"] = "BitTorrent Protocol",
      ["69"] = "Tlen",
      ["70"] = "Tlen",
      ["74"] = "Microsoft MSN Messenger",
      ["76"] = "Microsoft MSN Messenger",
      ["77"] = "Hotspot Shield VPN",
      ["78"] = "Flash Video (FLV)",
      ["79"] = "Xunlei Thunder",
      ["84"] = "QQDownload",
      ["87"] = "ICQ",
      ["89"] = "QQDownload",
      ["94"] = "Microsoft MSN Messenger",
      ["95"] = "IRC",
      ["100"] = "IRC",
      ["101"] = "IRC",
      ["102"] = "AIM",
      ["103"] = "AIM",
      ["104"] = "AIM",
      ["107"] = "NomaDesk",
      ["108"] = "NomaDesk",
      ["110"] = "NomaDesk",
      ["112"] = "NewsStand",
      ["113"] = "Netlog",
      ["118"] = "QQDownload",
      ["119"] = "The Motley Fool",
      ["120"] = "Morningstar",
      ["121"] = "AIM/ICQ",
      ["123"] = "Microsoft Silverlight",
      ["127"] = "QQDownload",
      ["128"] = "PPStream",
      ["129"] = "PPStream",
      ["130"] = "PPStream",
      ["133"] = "Telnet",
      ["135"] = "GOGOBOX",
      ["136"] = "Morningstar",
      ["137"] = "Morningstar",
      ["138"] = "Oracle",
      ["139"] = "Kerberos v5",
      ["140"] = "TeamViewer",
      ["141"] = "AIM",
      ["143"] = "AIM",
      ["605"] = "Microsoft Task Scheduler",
      ["606"] = "Microsoft DNS",
      ["607"] = "Microsoft WINS",
      ["608"] = "Microsoft WINS",
      ["609"] = "Microsoft Exchange",
      ["610"] = "Microsoft Exchange",
      ["612"] = "Microsoft Exchange",
      ["613"] = "Microsoft Exchange",
      ["615"] = "Microsoft Exchange",
      ["616"] = "Microsoft Exchange",
      ["617"] = "Microsoft Exchange",
      ["618"] = "Microsoft Exchange",
      ["620"] = "Microsoft Exchange",
      ["621"] = "Microsoft Exchange",
      ["622"] = "Microsoft Exchange",
      ["625"] = "Microsoft Exchange",
      ["626"] = "Microsoft Exchange",
      ["627"] = "Microsoft Exchange",
      ["628"] = "QuakeLive",
      ["629"] = "Eachnet",
      ["630"] = "Eachnet",
      ["632"] = "CVSup",
      ["633"] = "163.com Webmail",
      ["634"] = "Trend Micro",
      ["635"] = "163.com Webmail",
      ["638"] = "Geni",
      ["639"] = "Gnolia",
      ["640"] = "NetFlow v9",
      ["641"] = "NetFlow v9",
      ["642"] = "Gaia Online",
      ["643"] = "Gaia Online",
      ["644"] = "Microsoft SQL Server",
      ["645"] = "Clarizen",
      ["654"] = "Nagios",
      ["655"] = "Nagios",
      ["656"] = "Nagios",
      ["657"] = "Nagios",
      ["658"] = "Kerberos v5",
      ["661"] = "Kerberos v5",
      ["663"] = "Kerberos v5",
      ["666"] = "LDAP v3",
      ["667"] = "LDAP v3",
      ["668"] = "LDAP v3",
      ["669"] = "LDAP v3",
      ["670"] = "Radius",
      ["671"] = "Radius",
      ["672"] = "TACACS Plus",
      ["673"] = "TACACS Plus",
      ["674"] = "TACACS Plus",
      ["675"] = "TACACS Plus",
      ["3256"] = "Archive",
      ["3257"] = "Archive",
      ["3259"] = "Archive",
      ["3260"] = "Archive",
      ["3261"] = "Archive",
      ["3262"] = "Archive",
      ["3263"] = "Archive",
      ["3264"] = "Toonel.net",
      ["3265"] = "Microsoft OneDrive",
      ["3266"] = "Tonido",
      ["3267"] = "Windows Live Messenger File Transfer",
      ["3269"] = "XML",
      ["3270"] = "Microsoft OneDrive",
      ["3271"] = "XML",
      ["3272"] = "XML",
      ["3273"] = "Box",
      ["3274"] = "Box",
      ["3275"] = "Tonido",
      ["3277"] = "Tonido",
      ["3279"] = "Tonido",
      ["3281"] = "ZumoDrive",
      ["3282"] = "Ares",
      ["3283"] = "Ares",
      ["3284"] = "XML",
      ["3285"] = "Livedrive",
      ["3289"] = "DBank",
      ["3291"] = "21CN Webmail",
      ["3295"] = "Tianya Webmail",
      ["3296"] = "Lenovo Data",
      ["3297"] = "Syncplicity",
      ["3303"] = "Windows Live Messenger File Transfer",
      ["3307"] = "JWChat",
      ["3313"] = "Zoho Chat",
      ["3314"] = "CitrixWire",
      ["3315"] = "SpiderOak",
      ["3317"] = "FrostWire",
      ["3318"] = "FrostWire",
      ["3319"] = "Crux P2P",
      ["3321"] = "BT Chat",
      ["3324"] = "WordPress",
      ["3325"] = "BT Chat",
      ["3328"] = "BTMon",
      ["3329"] = "BTMon",
      ["3330"] = "BitTorrent.am",
      ["3331"] = "magicVORTEX",
      ["3333"] = "BitTorrent.am",
      ["3340"] = "Magic MP3 Tagger",
      ["3345"] = "Full DLs",
      ["3348"] = "Full DLs",
      ["3349"] = "H33t",
      ["7868"] = "CPX Interactive",
      ["7869"] = "SayMedia",
      ["7870"] = "Casale Media",
      ["7871"] = "Betr Ad",
      ["7872"] = "Double Verify",
      ["7873"] = "Optimizely",
      ["7874"] = "Optimax Media Delivery",
      ["7875"] = "Atwola",
      ["7876"] = "Admailtiser",
      ["7877"] = "Criteo",
      ["7878"] = "CMP Advisors",
      ["7879"] = "United Internet Media",
      ["7880"] = "eXelate Media",
      ["7881"] = "Adsrvr",
      ["7882"] = "Casale Media",
      ["7883"] = "Site Scout",
      ["7884"] = "RealMedia",
      ["7885"] = "Google Analytics",
      ["7887"] = "AOL Advertising",
      ["7888"] = "eyeReturn Marketing",
      ["7889"] = "Ministerial5",
      ["7890"] = "Super Sonic Ads",
      ["7891"] = "AppNexus",
      ["7892"] = "MediaMath",
      ["7893"] = "Media Innovation Group",
      ["7894"] = "Eq Ads",
      ["7895"] = "BlueKai Research",
      ["7896"] = "BlueKai Research",
      ["7898"] = "AppNexus",
      ["7899"] = "Ministerial5",
      ["7900"] = "DoubleClick",
      ["7901"] = "AdTech",
      ["7902"] = "PointRoll",
      ["7903"] = "ABMR",
      ["7904"] = "Chango Marketing",
      ["7905"] = "ADGRX",
      ["7906"] = "Adnetik",
      ["7907"] = "Aggregrate Knowledge",
      ["7908"] = "Accuen Media",
      ["7909"] = "Turn Advertising",
      ["7910"] = "Adsafe Media",
      ["7911"] = "Media6Degrees",
      ["7912"] = "ooVoo",
      ["7913"] = "ooVoo",
      ["7914"] = "ooVoo",
      ["7926"] = "SSL",
      ["7927"] = "SSL",
      ["7929"] = "ExpatShield",
      ["7930"] = "ExpatShield",
      ["7936"] = "TextPlus",
      ["49152"] = "Firewall management",
      ["49153"] = "General Broadcast",
      ["49154"] = "General Multicast",
      ["49155"] = "General Unicast",
      ["49156"] = "General Subnet broadcast",
      ["49157"] = "General PPTP control",
      ["49158"] = "General PPTP data",
      ["49159"] = "General RAS control",
      ["49160"] = "General RAS data",
      ["49161"] = "General Oracle data",
      ["49162"] = "General Oracle data",
      ["49163"] = "General RT stream",
      ["49164"] = "General SIP stream",
      ["49165"] = "General NETBIOS",
      ["49166"] = "General IKE",
      ["49167"] = "General EMAIL",
      ["49168"] = "General DHCP",
      ["49169"] = "General DNS",
      ["49170"] = "General FTP control",
      ["49171"] = "General FTP data",
      ["49172"] = "General GOPHER",
      ["49173"] = "General H323 control",
      ["49174"] = "General H323 media",
      ["49175"] = "General HTTP",
      ["49176"] = "General HTTP MGMT",
      ["49177"] = "General HTTPS",
      ["49178"] = "General HTTPS MGMT",
      ["49179"] = "General LDAP",
      ["49180"] = "General MSN",
      ["49181"] = "General MSN media",
      ["49182"] = "General NETBIOS",
      ["49183"] = "General NNTP",
      ["49184"] = "General NTP",
      ["49185"] = "General POP3",
      ["49186"] = "General RADIUS",
      ["49187"] = "General RIP",
      ["49188"] = "General RTSP control",
      ["49189"] = "General RTSP media",
      ["49190"] = "General SIP control",
      ["49191"] = "General SIP media",
      ["49192"] = "General SMTP",
      ["49193"] = "General SNMP",
      ["49194"] = "General SNMP Trap",
      ["49195"] = "General SSH",
      ["49196"] = "General SYSLOG",
      ["49197"] = "General Telnet",
      ["49198"] = "General Tftp",
      ["49199"] = "General Tftp data",
      ["49200"] = "General URL",
      ["49201"] = "General TCP",
      ["49202"] = "General UDP",
      ["49203"] = "General ICMP",
      ["49204"] = "General IGMP",
      ["49205"] = "General GRE",
      ["49206"] = "General IPSEC ESP",
      ["49207"] = "General IPSEC AH",
      ["49208"] = "General OSPF",
      ["49209"] = "General PIM SM",
      ["49210"] = "General EIGRP",
      ["49211"] = "General IPCOMP",
      ["49212"] = "General 6to4",
      ["49213"] = "General IPinIP",
      ["49214"] = "General ETHERinIP",
      ["49215"] = "General VRRP",
      ["49216"] = "General L2TP",
      ["49217"] = "General RSVP",
      ["49218"] = "General FiberChannel",
      ["49219"] = "General MPLSinIP",
      ["49220"] = "General LLMNR",
      ["49221"] = "Service HTTP",
      ["49222"] = "Service HTTP Management",
      ["49223"] = "Service HTTPS",
      ["49224"] = "Service HTTPS Management",
      ["49225"] = "Service HTTPS Redirect",
      ["49226"] = "Service RADIUS Accounting",
      ["49227"] = "Service SSO 3rd-Party API",
      ["49228"] = "Service IDENT",
      ["49229"] = "Service IMAP3",
      ["49230"] = "Service IMAP4",
      ["49231"] = "Service ISAKMP",
      ["49232"] = "Service LDAP",
      ["49233"] = "Service LDAP (UDP)",
      ["49234"] = "Service LDAPS",
      ["49235"] = "Service LPR (Unix Printer)",
      ["49236"] = "Service Megaco H.248 TCP",
      ["49237"] = "Service Megaco Text H.248 UDP",
      ["49238"] = "Service Megaco Binary H.248 UDP",
      ["49239"] = "Service MS SQL",
      ["49240"] = "Service NNTP (News)",
      ["49241"] = "Service NTP",
      ["49242"] = "Service POP3 (Retrieve E-Mail)",
      ["49243"] = "Service Terminal Services TCP",
      ["49244"] = "Service Terminal Services UDP",
      ["49245"] = "Service PPTP",
      ["49246"] = "Service SMTP (Send E-Mail)",
      ["49247"] = "Service SNMP",
      ["49248"] = "Service SQL*Net",
      ["49249"] = "Service SSH",
      ["49250"] = "Service Telnet",
      ["49251"] = "Service TFTP",
      ["49252"] = "Service Citrix TCP",
      ["49253"] = "Service Citrix TCP (Session Reliability",
      ["49254"] = "Service Citrix UDP",
      ["49255"] = "Service IRC (Chat) 194",
      ["49256"] = "Service IRC (Chat) 6666-6670",
      ["49257"] = "Service IRC (Chat) 7000",
      ["49258"] = "Service DNS (Name Service) TCP",
      ["49259"] = "Service DNS (Name Service) UDP",
      ["49260"] = "Service Enhanced TV",
      ["49261"] = "Service ESP (IPSec)",
      ["49262"] = "Service FTP",
      ["49263"] = "Service FTP Data",
      ["49264"] = "Service FTP Control",
      ["49265"] = "Service Gopher",
      ["49266"] = "Service IKE (Key Exchange)",
      ["49267"] = "Service IKE (Traversal)",
      ["49268"] = "Service Lotus Notes",
      ["49269"] = "Service Echo Reply",
      ["49270"] = "Service Destination Unreachable",
      ["49271"] = "Service Source Quench",
      ["49272"] = "Service Redirect",
      ["49273"] = "Service Echo",
      ["49274"] = "Service Router Advertisement",
      ["49275"] = "Service Router Solicitation",
      ["49276"] = "Service Time Exceeded",
      ["49277"] = "Service Ping 0",
      ["49278"] = "Service Ping 8",
      ["49279"] = "Service Kerberos TCP",
      ["49280"] = "Service Kerberos UDP",
      ["49281"] = "Service NetBios NS TCP",
      ["49282"] = "Service NetBios NS UDP",
      ["49283"] = "Service NetBios DGM TCP",
      ["49284"] = "Service NetBios DGM UDP",
      ["49285"] = "Service NetBios SSN TCP",
      ["49286"] = "Service NetBios SSN UDP",
      ["49287"] = "Service SMB",
      ["49288"] = "Service NFS TCP",
      ["49289"] = "Service NFS UDP",
      ["49290"] = "Service Syslog TCP",
      ["49291"] = "Service Syslog UDP",
      ["49292"] = "Service SIP UDP",
      ["49293"] = "Service SIP TCP",
      ["49294"] = "Service H323 Call Signaling",
      ["49295"] = "Service H323 Gatekeeper Discovery",
      ["49296"] = "Service H323 Gatekeeper RAS",
      ["49297"] = "Service MGCP TCP",
      ["49298"] = "Service MGCP UDP",
      ["49299"] = "Service Skinny",
      ["49300"] = "Service T120 (Whiteboard+A43)",
      ["49301"] = "Service PC Anywhere TCP",
      ["49302"] = "Service PC Anywhere UDP",
      ["49303"] = "Service Timbuktu TCP 407",
      ["49304"] = "Service Timbuktu UDP 407",
      ["49305"] = "Service Timbuktu TCP 1417-1420",
      ["49306"] = "Service Timbuktu UDP 1419",
      ["49307"] = "Service RTSP TCP",
      ["49308"] = "Service RTSP UDP",
      ["49309"] = "Service PNA",
      ["49310"] = "Service MMS TCP",
      ["49311"] = "Service MMS UDP",
      ["49312"] = "Service MSN TCP",
      ["49313"] = "Service MSN UDP",
      ["49314"] = "Service Squid",
      ["49315"] = "Service Yahoo Messenger TCP",
      ["49316"] = "Service Yahoo Messenger UDP",
      ["49317"] = "Service VNC 5500",
      ["49318"] = "Service VNC 5800",
      ["49319"] = "Service VNC 5900",
      ["49320"] = "Service Remotely Anywhere",
      ["49321"] = "Service Remotely Possible",
      ["49322"] = "Service Quake",
      ["49323"] = "Service cu-seeme",
      ["49324"] = "Service Edonkey TCP",
      ["49325"] = "Service Edonkey UDP",
      ["49326"] = "Service WinMX TCP 6699",
      ["49327"] = "Service WinMX TCP 7729-7735",
      ["49328"] = "Service WinMX UDP 6257",
      ["49329"] = "Service Kazaa / FastTrack",
      ["49330"] = "Service iMesh",
      ["49331"] = "Service Direct Connect",
      ["49332"] = "Service BearShare",
      ["49333"] = "Service ZebTelnet",
      ["49334"] = "Service Membership Query",
      ["49335"] = "Service V2 Membership Report",
      ["49336"] = "Service Leave Group",
      ["49337"] = "Service V3 Membership Report",
      ["49338"] = "Service GMS HTTPS",
      ["49339"] = "Service Radius",
      ["49340"] = "Service GSCTrace",
      ["49341"] = "Service SSH Management",
      ["49342"] = "Service NT Domain Login Port 1025",
      ["49343"] = "Service DCE EndPoint",
      ["49344"] = "Service External Guest Authentication",
      ["49345"] = "Service ShoreTel Call Control",
      ["49346"] = "Service ShoreTel RTP",
      ["49347"] = "Service ShoreTel IP Phone Control 2427",
      ["49348"] = "Service ShoreTel IP Phone Control 2727",
      ["49349"] = "Service Tivo TCP Beacon",
      ["49350"] = "Service Tivo UDP Beacon",
      ["49351"] = "Service Tivo TCP Data",
      ["49352"] = "Service Tivo TCP Desktop (8101/8102)",
      ["49353"] = "Service Tivo TCP Desktop (8200)",
      ["49354"] = "Service IPcomp",
      ["49355"] = "Service Apple Bonjour",
      ["49356"] = "Service SMTP (Anti-Spam Inbound Port)",
      ["49357"] = "Service SSLVPN",
      ["49358"] = "Service SonicpointN Layer3 Management",
      ["49359"] = "Service SonicWALL Console Proxy",
      ["49360"] = "Service BGP",
      ["49361"] = "Service 6over4",
      ["49362"] = "Service Host Name Server TCP",
      ["49363"] = "Service Host Name Server UDP",
      ["49364"] = "Service NetBios TCP",
      ["49365"] = "Service NetBios UDP",
      ["49366"] = "Service RPC Services",
      ["49367"] = "Service RPC Services (IANA)",
      ["49368"] = "Service DRP",
      ["49369"] = "Service NetFlow / IPFIX",
      ["49370"] = "Service Rip",
      ["49371"] = "Service Destination Unreachable (IPv6)",
      ["49372"] = "Service Packet Too Big",
      ["49373"] = "Service Time Exceeded (IPv6)",
      ["49374"] = "Service Parameter Problem",
      ["49375"] = "Service Echo (IPv6)",
      ["49376"] = "Service Echo Reply (IPv6)",
      ["49377"] = "Service Router Solicitation (IPv6)",
      ["49378"] = "Service Router Advertisement (IPv6)",
      ["49379"] = "Service Neighbor Solicitation",
      ["49380"] = "Service Neighbor Advertisement",
      ["49381"] = "Service Redirect (IPv6)",
      ["49382"] = "Service Ping6 128",
      ["49383"] = "Service Ping6 129",
      ["49384"] = "Service GRE",
      ["49385"] = "Service Comm Dst Host Admin Prohibited",
      ["49386"] = "Service Dst Network Unreachable",
      ["49387"] = "Service Dst Host Unreachable",
      ["49388"] = "Service Communication Admin Prohibited",
      ["49389"] = "Service Redr Datagram for the Host",
      ["49390"] = "Service Redr Datagram for Service and N",
      ["49391"] = "Service Redr Datagram for Service and H",
      ["49392"] = "Service Fragment Reassembly Time Exceed",
      ["49393"] = "Service Parameter Problem(IPv4)",
      ["49394"] = "Service Missing a Required Option",
      ["49395"] = "Service Bad Length",
      ["49396"] = "Service Timestamp",
      ["49397"] = "Service Timestamp Reply",
      ["49398"] = "Service Information Request",
      ["49399"] = "Service Information Reply",
      ["49400"] = "Service Address Mask Request",
      ["49401"] = "Service Address Mask Reply",
      ["49402"] = "Service Traceroute",
      ["49403"] = "Service Datagram Conversion Error",
      ["49404"] = "Service Mobile Host Redirect",
      ["49405"] = "Service Mobile Registration Request",
      ["49406"] = "Service Mobile Registration Reply",
      ["49407"] = "Service Commu Dstination Admin Prohibit",
      ["49408"] = "Service Beyond Scope of Source Address",
      ["49409"] = "Service Address Unreachable",
      ["49410"] = "Service Port Unreachable (IPv6)",
      ["49411"] = "Service Src Address Failed Ingress Egre",
      ["49412"] = "Service Reject Route to Destination",
      ["49413"] = "Service Error in Source Routing Header",
      ["49414"] = "Service Frgm Reassembly Time Exceeded (",
      ["49415"] = "Service Unrecg Next Header Type Encount",
      ["49416"] = "Service Unrecg IPv6 Operation Encount",
      ["49417"] = "Service Multicast Listener Query (IPv6)",
      ["49418"] = "Service Multicast Listener Report (IPv6",
      ["49419"] = "Service Multicast Listener Done (IPv6)",
      ["49420"] = "Service Router Renumbering (IPv6)",
      ["49421"] = "Service Router Renumbering Result (IPv6",
      ["49422"] = "Service Sequence Number Reset (IPv6)",
      ["49423"] = "Service ICMP Node Information Query (IP",
      ["49424"] = "Service contain empty name (IPv6)",
      ["49425"] = "Service contain IPv4 address (IPv6)",
      ["49426"] = "Service ICMP Node Information Response",
      ["49427"] = "Service Responder refuses (IPv6)",
      ["49428"] = "Service Qtype of the Query is unknown (",
      ["49429"] = "Service Inverse Neighbor Discovery Soli",
      ["49430"] = "Service Inverse Neighbor Discovery Adve",
      ["49431"] = "Service Version 2 Multicast Listener Re",
      ["49432"] = "Service Home Agent Address Discovery Re",
      ["49433"] = "Service Home Agent Address Discovery Re",
      ["49434"] = "Service Mobile Prefix Solicitation (IPv",
      ["49435"] = "Service Mobile Prefix Advertisement (IP",
      ["49436"] = "Service Certification Path Solicitation",
      ["49437"] = "Service Certification Path Advertisemen",
      ["49438"] = "Service ICMP messages utilized (IPv6)",
      ["49439"] = "Service Multicast Router Advertisement",
      ["49440"] = "Service Multicast Router Solicitation (",
      ["49441"] = "Service Multicast Router Termination (I",
      ["49442"] = "Service FMIPv6 Messages (IPv6)",
      ["49443"] = "Service RPL Control Message (IPv6)",
      ["49444"] = "Service Alternative Address for Host",
      ["49445"] = "Service GMSFlow-2055",
      ["49446"] = "Service GMSFlow-9060",      
   }
}

-- ################################################################################

function sonicwall.map_field_value(field_type, value)
   if type_value_map[field_type] and type_value_map[field_type][value] then
      value = type_value_map[field_type][value]
   end

   if type_map[field_type] then
      field_type = type_map[field_type]
   end

   return field_type, value
end

-- ################################################################################

return sonicwall
