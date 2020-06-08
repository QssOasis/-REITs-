
CREATE TABLE bond (
  bid char(6) NOT NULL  PRIMARY KEY,
  bname varchar(50) ,
  level int(1) ,
  deadline int(2) ,
  denomination int(3) ,
  financingScale int(10) ,
  annualInterestRate double(5,4) ,
  releaseStartTime datetime ,
  releaseEndTime datetime ,
  issuePrice int(3) ,
  issueTurnover int(8) ,
  purchasedTurnover int(10) ,
  listingDate datetime ,
  totalTransactionAmount double(15,2),
  totalTurnover int(10) ,
  bstatement int(1)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE company_basic_info (
  cid char(11) NOT NULL,
  ctel char(14) DEFAULT NULL,
  cpassword varchar(20) DEFAULT NULL,
  cmailBox varchar(20) DEFAULT NULL,
  cregisterName varchar(10) DEFAULT NULL,
  cregisterIDtype char(10) DEFAULT NULL,
  cregisterIDCard char(20) DEFAULT NULL,
  cregisterBankAccount char(25) DEFAULT NULL,
  cname varchar(20) DEFAULT NULL,
  coffice varchar(255) DEFAULT NULL,
  cICRegistrationNum char(13) DEFAULT NULL,
  cindustry varchar(10) DEFAULT NULL,
  cintroduction text,
  corpName varchar(10) DEFAULT NULL,
  corpIDtype char(10) DEFAULT NULL,
  corpIDcard char(20) DEFAULT NULL,
  corpTel char(14) DEFAULT NULL,
  flag int(11) DEFAULT '2',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE company_financing_info (
  cfiid char(11) NOT NULL,
  cid char(11) DEFAULT NULL,
  cfiApplydate datetime DEFAULT NULL,
  cfiGetMoneyDate datetime DEFAULT NULL,
  financingProjectName varchar(50) DEFAULT NULL,
  financingDeadline int(2) DEFAULT NULL,
  financingAmount int(9) DEFAULT NULL,
  introductionOfAssets text,
  exceptCashFlow double(15,2) DEFAULT NULL,
  exceptCashFlow3 double(15,2) DEFAULT NULL,
  exceptCashFlow6 double(15,2) DEFAULT NULL,
  exceptCashFlow9 double(15,2) DEFAULT NULL,
  exceptCashFlow12 double(15,2) DEFAULT NULL,
  exceptCashFlow24 double(15,2) DEFAULT NULL,
  materialPath varchar(15) DEFAULT NULL,
  expectPaymentTime datetime DEFAULT NULL,
  actualPaymentTime datetime DEFAULT NULL,
  statement int(1) DEFAULT NULL,
  liquidityRatio double(9,6) DEFAULT '0.000000',
  quickRatio double(9,6) DEFAULT NULL,
  cashRatio double(9,6) DEFAULT NULL,
  WorkingCapitalpercent double(9,6) DEFAULT NULL,
  debttoassetsRatio double(9,6) DEFAULT NULL,
  PropertyRatio double(9,6) DEFAULT NULL,
  Cashflowratio double(9,6) DEFAULT NULL,
  Debtsecurityrate double(9,6) DEFAULT NULL,
  Operatingincomecashratio double(9,6) DEFAULT NULL,
  Netinterestrateonsales double(9,6) DEFAULT NULL,
  ROA1 double(9,6) DEFAULT NULL,
  ROA2 double(9,6) DEFAULT NULL,
  ROE double(9,6) DEFAULT NULL,
  Turnoverrateofaccountsreceivable double(9,6) DEFAULT NULL,
  Inventoryturnoverrate double(9,6) DEFAULT NULL,
  Currentassetturnoverrate double(9,6) DEFAULT NULL,
  Totalassetsturnover double(9,6) DEFAULT NULL,
  Totalassetsgrowthrate double(9,6) DEFAULT NULL,
  Operatingincomegrowth double(9,6) DEFAULT NULL,
  Totalretainedearningsperccent double(9,6) DEFAULT NULL,
  PRIMARY KEY (`cfiid`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE bond_company_financing
 (
  bcfid varchar(255) NOT NULL,
  bid varchar(255) DEFAULT NULL,
  cfiid varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bcfid`),
  FOREIGN KEY (`bid`) REFERENCES `bond` (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE datamaintenance (
  dmid char(11) DEFAULT NULL,
  x1 double(9,6) DEFAULT NULL,
  x2 double(9,6) DEFAULT NULL,
  x3 double(9,6) DEFAULT NULL,
  x4 double(9,6) DEFAULT NULL,
  x5 double(9,2) DEFAULT NULL,
  x6 double(9,6) DEFAULT NULL,
  x7 double(9,6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;





CREATE TABLE bond_loan_loss_provision (
  bid char(6) NOT NULL,
  loanLossProvision int(9) NOT NULL,
  PRIMARY KEY (`bid`),
  FOREIGN KEY (`bid`) REFERENCES `bond` (`bid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE company_financing_money (
  cfiid varchar(255) NOT NULL,
  financingAmount int(11) DEFAULT NULL,
  loanRate double(5,4) DEFAULT NULL,
  actualPaymentAmount double(13,2) DEFAULT NULL,
  PRIMARY KEY (`cfiid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE user_basic_info (
  uid char(11) NOT NULL,
  utel char(14) DEFAULT NULL,
  umailBox varchar(20) DEFAULT NULL,
  upassword varchar(20) DEFAULT NULL,
  urealName varchar(10) DEFAULT NULL,
  unickName varchar(10) DEFAULT NULL,
  uIDType char(10) DEFAULT NULL,
  uIDCard char(20) DEFAULT NULL,
  riskLevel int(1) DEFAULT NULL,
  registerTime datetime DEFAULT NULL,
  lastLogin datetime DEFAULT NULL,
  flag int(1) DEFAULT '1',
  question varchar(25) DEFAULT NULL,
  answer varchar(10) DEFAULT NULL,
  photo varchar(50) DEFAULT NULL,
  PRIMARY KEY (`uid`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE message (
  mid char(11) NOT NULL,
  type int(1) DEFAULT NULL,
  senderid char(11) DEFAULT NULL,
  receiverid char(11) DEFAULT NULL,
  date datetime DEFAULT NULL,
  head varchar(50) DEFAULT NULL,
  context text,
  isRead int(1) DEFAULT NULL,
  PRIMARY KEY (`mid`),
  FOREIGN KEY (`receiverid`) REFERENCES `user_basic_info` (`uid`),
  FOREIGN KEY (`senderid`) REFERENCES `user_basic_info` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE user_balance (
  uid char(11) NOT NULL,
  balance double(11,2) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE user_collect_bond (
  ucbid char(11) NOT NULL,
  bid char(6) DEFAULT NULL,
  ownerid char(11) DEFAULT NULL,
  PRIMARY KEY (`ucbid`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE user_own_bond (
  uobid char(11) NOT NULL,
  ownerid char(11) DEFAULT NULL,
  bid char(6) DEFAULT NULL,
  uobprice double(6,2) DEFAULT NULL,
  uobturnover int(11) DEFAULT NULL,
  statement int(1) DEFAULT '1',
  startdate datetime DEFAULT NULL,
  enddate datetime DEFAULT NULL,
  PRIMARY KEY (`uobid`),
  FOREIGN KEY (`bid`) REFERENCES `bond` (`bid`),
  FOREIGN KEY (`ownerid`) REFERENCES `user_basic_info` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE user_trade_bond (
  utbid char(11) NOT NULL,
  bid char(6) DEFAULT NULL,
  buyerid char(11) DEFAULT NULL,
  sellerid char(11) DEFAULT NULL,
  utbprice double(6,2) DEFAULT NULL,
  utbdate datetime DEFAULT NULL,
  utbturnover int(6) DEFAULT NULL,
  type int(1) DEFAULT NULL,
  statement int(1) DEFAULT NULL,
  failedResult varchar(50) DEFAULT NULL,
  PRIMARY KEY (`utbid`),
  KEY `FKBF58EDB26D104A6A` (`sellerid`),
  FOREIGN KEY (`sellerid`) REFERENCES `user_basic_info` (`uid`),
  FOREIGN KEY (`bid`) REFERENCES `bond` (`bid`),
  FOREIGN KEY (`buyerid`) REFERENCES `user_basic_info` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE user_trust_deed (
  utdid char(11) NOT NULL,
  bid char(6) DEFAULT NULL,
  ownerid char(11) DEFAULT NULL,
  startDate datetime DEFAULT NULL,
  utdturnover int(10) DEFAULT NULL,
  utdprice double(6,2) DEFAULT NULL,
  type int(1) DEFAULT NULL,
  purchasedturnover int(10) DEFAULT NULL,
  PRIMARY KEY (`utdid`),
  FOREIGN KEY (`ownerid`) REFERENCES `user_basic_info` (`uid`),
  FOREIGN KEY (`bid`) REFERENCES `bond` (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE user_or_com_bank (
  baid char(11) NOT NULL,
  cid char(11) DEFAULT NULL,
  uid char(11) DEFAULT NULL,
  bankAccount char(19) DEFAULT NULL,
  PRIMARY KEY (`baid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;





CREATE TABLE spv_basic_info (
  spvid char(11) NOT NULL,
  spvname varchar(10) DEFAULT NULL,
  spvlevel int(1) DEFAULT NULL,
  flag int(1) DEFAULT '3',
  spvtel char(14) DEFAULT NULL,
  spvpassword varchar(20) DEFAULT NULL,
  extralPassword varchar(20) DEFAULT NULL,
  PRIMARY KEY (`spvid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



