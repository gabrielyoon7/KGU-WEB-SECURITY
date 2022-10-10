DROP DATABASE if EXISTS `test_db` ;
create database test_db default character set utf8;
use test_db;

-- MySQL dump 10.13  Distrib 8.0.21, for Linux (x86_64)
--
-- Host: localhost    Database: kgcs
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `back_certificate_data`
--

DROP TABLE IF EXISTS `back_certificate_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `back_certificate_data` (
                                         `per_id` int NOT NULL,
                                         `requirement` varchar(45) DEFAULT NULL,
                                         `cer_id` varchar(45) DEFAULT NULL,
                                         `organization` varchar(45) DEFAULT NULL,
                                         `acq_date` datetime DEFAULT NULL,
                                         `cer_filename` text,
                                         PRIMARY KEY (`per_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `back_certificate_data`
--

LOCK TABLES `back_certificate_data` WRITE;
/*!40000 ALTER TABLE `back_certificate_data` DISABLE KEYS */;

/*!40000 ALTER TABLE `back_certificate_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `back_conference_data`
--

DROP TABLE IF EXISTS `back_conference_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `back_conference_data` (
                                        `per_id` int NOT NULL,
                                        `conference_name` varchar(45) DEFAULT NULL,
                                        `requirement` varchar(45) DEFAULT NULL,
                                        `thesis_title` text,
                                        `organization` varchar(45) DEFAULT NULL,
                                        `open_date` datetime DEFAULT NULL,
                                        `thesis_filename` text,
                                        `proof_filename` text,
                                        PRIMARY KEY (`per_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `back_conference_data`
--

LOCK TABLES `back_conference_data` WRITE;
/*!40000 ALTER TABLE `back_conference_data` DISABLE KEYS */;

/*!40000 ALTER TABLE `back_conference_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `back_contest_data`
--

DROP TABLE IF EXISTS `back_contest_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `back_contest_data` (
                                     `per_id` int NOT NULL,
                                     `contest_name` varchar(45) DEFAULT NULL,
                                     `contest_content` varchar(45) DEFAULT NULL,
                                     `organization` varchar(45) DEFAULT NULL,
                                     `award_date` datetime DEFAULT NULL,
                                     `open_date` datetime DEFAULT NULL,
                                     `award_filename` text,
                                     `add_filename` text,
                                     `team_type` varchar(45) DEFAULT NULL,
                                     PRIMARY KEY (`per_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `back_contest_data`
--

LOCK TABLES `back_contest_data` WRITE;
/*!40000 ALTER TABLE `back_contest_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `back_contest_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `back_students`
--

DROP TABLE IF EXISTS `back_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `back_students` (
                                 `per_id` int NOT NULL,
                                 `name` varchar(45) DEFAULT NULL,
                                 `prof_name` varchar(45) DEFAULT NULL,
                                 `graduation_date` varchar(45) DEFAULT NULL,
                                 `major` varchar(45) DEFAULT NULL,
                                 `graduation_type` varchar(45) DEFAULT NULL,
                                 `final_action_date` datetime DEFAULT NULL,
                                 PRIMARY KEY (`per_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `back_students`
--

LOCK TABLES `back_students` WRITE;
/*!40000 ALTER TABLE `back_students` DISABLE KEYS */;
/*!40000 ALTER TABLE `back_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `back_thesis_data`
--

DROP TABLE IF EXISTS `back_thesis_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `back_thesis_data` (
                                    `per_id` int NOT NULL,
                                    `title` text,
                                    `classification` varchar(45) DEFAULT NULL,
                                    `keyword` varchar(45) DEFAULT NULL,
                                    `proposal_content` text,
                                    `interim_filename` text,
                                    `final_requirement` text,
                                    `final_page` int DEFAULT NULL,
                                    `final_filename` text,
                                    PRIMARY KEY (`per_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `back_thesis_data`
--

LOCK TABLES `back_thesis_data` WRITE;
/*!40000 ALTER TABLE `back_thesis_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `back_thesis_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_level`
--

DROP TABLE IF EXISTS `board_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board_level` (
  `id` int NOT NULL,
  `article_name` varchar(50) NOT NULL,
  `read_level` int NOT NULL DEFAULT '9',
  `write_level` int NOT NULL DEFAULT '9',
  `read_comment_level` int NOT NULL DEFAULT '9',
  `write_comment_level` int NOT NULL DEFAULT '9',
  `file_download_level` int NOT NULL DEFAULT '9',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_level`
--

LOCK TABLES `board_level` WRITE;
/*!40000 ALTER TABLE `board_level` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `club`
--

DROP TABLE IF EXISTS `club`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `club` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clubname` varchar(45) NOT NULL,
  `clubcontent` text NOT NULL,
  `clubaddr` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club`
--

LOCK TABLES `club` WRITE;
/*!40000 ALTER TABLE `club` DISABLE KEYS */;
/*!40000 ALTER TABLE `club` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculum`
--

DROP TABLE IF EXISTS `curriculum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curriculum` (
                              `major` varchar(50) NOT NULL,
                              `year` int NOT NULL,
                              `curriculum_img` varchar(100) NOT NULL,
                              `edu_img` varchar(100) NOT NULL,
                              PRIMARY KEY (`major`,`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculum`
--

LOCK TABLES `curriculum` WRITE;
/*!40000 ALTER TABLE `curriculum` DISABLE KEYS */;
/*!40000 ALTER TABLE `curriculum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fdb_pages`
--

DROP TABLE IF EXISTS `fdb_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fdb_pages` (
                             `id` int NOT NULL AUTO_INCREMENT,
                             `path` varchar(50) NOT NULL,
                             `page_title` varchar(250) NOT NULL,
                             `tab_id` smallint unsigned NOT NULL,
                             `show_in_menus` tinyint(1) NOT NULL DEFAULT '1',
                             `max_level` smallint unsigned NOT NULL DEFAULT '9',
                             `orderNum` smallint unsigned NOT NULL,
                             `min_level` smallint NOT NULL DEFAULT '0',
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fdb_pages`
--

LOCK TABLES `fdb_pages` WRITE;
/*!40000 ALTER TABLE `fdb_pages` DISABLE KEYS */;
INSERT INTO `fdb_pages` VALUES (1,'community_club.kgu','동아리 소개',2,1,11,3,0),(2,'notice_article_list.do','인공지능 게시판',7,1,11,1,0),(19,'information.kgu','안내 및 내규',9,1,11,2,0),(20,'graduation_intro.do','나의 졸업논문',9,2,11,4,1),(21,'notice_article_list.do','공지사항',9,1,11,1,0),(26,'graduation_schedule.do','진행일정',9,1,11,3,0),(27,'laboratory.do','연구실',3,1,11,2,0),(28,'professor.do','교수소개',3,1,11,1,0),(29,'notice_article_list.do','전체공지',4,1,11,1,0),(31,'req_article_list.do','신청 및 접수',5,1,8,1,0),(41,'notice_article_list.do','학과공지',4,1,11,2,0),(46,'notice_article_list.do','취업공지',4,1,11,4,0),(51,'notice_article_list.do','수업공지',4,1,11,3,0),(56,'information.kgu','학과소개',1,1,11,1,0),(57,'information.kgu','연혁',1,1,11,2,0),(58,'information.kgu','교육목표',1,1,11,4,0),(59,'information.kgu','교육환경',1,1,11,3,0),(60,'curriculum.kgu','교육과정',2,1,11,1,0),(61,'information.kgu','학습활동',2,1,11,2,0),(63,'admin.do','메인관리',8,1,4,1,0),(64,'admin.do','메뉴관리',8,1,4,2,0),(65,'admin.do','사용자관리',8,1,4,3,0),(66,'admin.do','엑셀관리',8,1,4,4,0),(70,'gallery_board_list.do','갤러리',7,1,9,2,0),(71,'graduation_list.do','졸업논문관리',9,3,11,7,1),(72,'webzine_list.do','학과 소식',6,1,11,1,0),(73,'webzine_list.do','우수 작품전',6,1,11,2,0),(74,'webzine_list.do','수상 소식',6,1,11,3,0),(76,'graduation_admin.do','신청서접수관리',9,4,11,6,1),(77,'graduation_admin.do','대상자전체관리',9,3,11,5,1),(78,'notice_article_list.do?num=91','졸업논문',5,1,6,2,0),(79,'admin.do','로그확인',8,1,4,5,0),(80,'admin.do','관리자게시판',8,1,4,6,0),(81,'notice_article_list.do','학과 자료실',5,1,6,3,0),(82,'graduate_list.do','졸업자 조회',9,3,11,5,1),(84,'graduate_myinfo.do','졸업 조회',9,2,11,4,1),(86,'mytrack.do','나의 이수 현황',10,1,11,1,0),(87,'mytrack_semester.do','이수 현황 등록',10,1,11,2,0),(88,'locker_schedule.do?num=111','사물함 신청',5,1,6,5,0),(89,'track_view.do','트랙 보기',10,1,11,4,0),(90,'course_view.do','교육 과정 보기',10,1,11,5,0),(91,'admin.do','ai권한관리',8,1,4,7,0),(92,'locker_schedule.do','일정',11,1,11,1,1),(93,'locker_apply.do','나의 사물함',11,1,11,2,1),(95,'locker_schedule.do','일정',11,1,11,4,1),(96,'locker_manager.do','사물함 관리',11,1,11,5,1),(97,'locker_apply_list.do','신청자 관리',11,1,11,6,1),(98,'locker_assigned_list.do','반납대상자 관리',11,1,11,7,1),(100,'graduation_checking_system.kgu?num=121','졸업요건 진단',2,1,11,4,0),(101,'graduation_checking_system.kgu','졸업요건 진단',12,1,11,1,0),(102,'graduation_checking_system.kgu','수강이력 입력하기',12,1,11,2,0),(103,'graduation_checking_system.kgu','졸업요건 관리',12,1,11,3,0),(104,'graduation_checking_system.kgu','학과강좌 관리',12,1,11,4,0),(105,'graduation_checking_system.kgu','학생DB 조회',12,1,11,5,0);
/*!40000 ALTER TABLE `fdb_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fdb_tabs`
--

DROP TABLE IF EXISTS `fdb_tabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fdb_tabs` (
                            `tab_id` smallint unsigned NOT NULL,
                            `tab_title` varchar(30) NOT NULL,
                            `tab_level` smallint unsigned NOT NULL,
                            `tab_img` varchar(30) NOT NULL,
                            `tab_url` varchar(50) NOT NULL,
                            `orderNum` smallint unsigned NOT NULL,
                            PRIMARY KEY (`tab_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fdb_tabs`
--

LOCK TABLES `fdb_tabs` WRITE;
/*!40000 ALTER TABLE `fdb_tabs` DISABLE KEYS */;
INSERT INTO `fdb_tabs` VALUES (1,'학과소개',4,'img/intro.gif','information.do?num=11',1),(2,'교육활동',4,'img/edu.png','curriculum.do?num=21',2),(3,'구성원',4,'img/member.png','professor.do?num=31',3),(4,'학과알림',4,'img/notice.png','notice_article_list.do?num=41',4),(5,'신청하기',4,'img/apply.png','req_article_list.do?num=51',5),(6,'웹진',4,'img/webzine.png','webzine_list.do?num=61',6),(7,'인공지능',4,'img/community.png','notice_article_list.do?num=71',7),(9,'졸업논문',4,'img/graduation.png','-',9);
/*!40000 ALTER TABLE `fdb_tabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gallery_boards`
--

DROP TABLE IF EXISTS `gallery_boards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gallery_boards` (
                                  `id` int NOT NULL AUTO_INCREMENT,
                                  `category` int NOT NULL,
                                  `writer_name` varchar(20) NOT NULL,
                                  `writer_id` varchar(30) NOT NULL,
                                  `title` varchar(250) NOT NULL,
                                  `content` varchar(600) NOT NULL,
                                  `img` varchar(200) NOT NULL DEFAULT '-',
                                  `last_modified` datetime NOT NULL,
                                  `view` int NOT NULL DEFAULT '0',
                                  `comments_count` int DEFAULT '0',
                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallery_boards`
--

LOCK TABLES `gallery_boards` WRITE;
/*!40000 ALTER TABLE `gallery_boards` DISABLE KEYS */;
/*!40000 ALTER TABLE `gallery_boards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gallery_comments`
--

DROP TABLE IF EXISTS `gallery_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gallery_comments` (
                                    `id` int NOT NULL AUTO_INCREMENT,
                                    `writer_id` varchar(45) NOT NULL,
                                    `writer_name` varchar(45) NOT NULL,
                                    `board_id` int NOT NULL,
                                    `last_modified` datetime NOT NULL,
                                    `content` varchar(200) NOT NULL,
                                    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallery_comments`
--

LOCK TABLES `gallery_comments` WRITE;
/*!40000 ALTER TABLE `gallery_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `gallery_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gallery_images`
--

DROP TABLE IF EXISTS `gallery_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gallery_images` (
                                  `id` int NOT NULL AUTO_INCREMENT,
                                  `board_id` int NOT NULL DEFAULT '0',
                                  `writer_id` varchar(30) NOT NULL,
                                  `src` varchar(200) NOT NULL,
                                  `text` varchar(100) NOT NULL DEFAULT '-',
                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallery_images`
--

LOCK TABLES `gallery_images` WRITE;
/*!40000 ALTER TABLE `gallery_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `gallery_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcs_engineering_requirement`
--

DROP TABLE IF EXISTS `gcs_engineering_requirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gcs_engineering_requirement` (
                                               `id` int NOT NULL AUTO_INCREMENT,
                                               `year` varchar(45) NOT NULL,
                                               `elective_credit` varchar(45) NOT NULL,
                                               `bsm_credit` varchar(50) NOT NULL,
                                               `design_credit` varchar(45) NOT NULL,
                                               `major_credit` varchar(45) NOT NULL,
                                               `lecture_order` text,
                                               `major` varchar(45) NOT NULL,
                                               PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcs_engineering_requirement`
--

LOCK TABLES `gcs_engineering_requirement` WRITE;
/*!40000 ALTER TABLE `gcs_engineering_requirement` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcs_engineering_requirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcs_external_lecture`
--

DROP TABLE IF EXISTS `gcs_external_lecture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gcs_external_lecture` (
                                        `per_id` varchar(45) NOT NULL,
                                        `year` varchar(10) NOT NULL,
                                        `semester` varchar(10) NOT NULL,
                                        `name` varchar(45) NOT NULL,
                                        `big_type` varchar(45) NOT NULL,
                                        `credit` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcs_external_lecture`
--

LOCK TABLES `gcs_external_lecture` WRITE;
/*!40000 ALTER TABLE `gcs_external_lecture` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcs_external_lecture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcs_external_lecture_history`
--

DROP TABLE IF EXISTS `gcs_external_lecture_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gcs_external_lecture_history` (
                                                `per_id` varchar(45) NOT NULL,
                                                `year` varchar(10) NOT NULL,
                                                `semester` varchar(10) NOT NULL,
                                                `history` text NOT NULL,
                                                PRIMARY KEY (`per_id`,`year`,`semester`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcs_external_lecture_history`
--

LOCK TABLES `gcs_external_lecture_history` WRITE;
/*!40000 ALTER TABLE `gcs_external_lecture_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcs_external_lecture_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcs_graduation_requirement`
--

DROP TABLE IF EXISTS `gcs_graduation_requirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gcs_graduation_requirement` (
                                              `id` int NOT NULL AUTO_INCREMENT,
                                              `year` int NOT NULL,
                                              `major` varchar(45) NOT NULL,
                                              `all_credit` int NOT NULL,
                                              `major_credit` int NOT NULL,
                                              `elective_credit` int NOT NULL,
                                              `major_essential` int NOT NULL,
                                              `major_selective` int NOT NULL,
                                              `jin_seong_ae_credit` int NOT NULL,
                                              `msc_credit` int NOT NULL,
                                              `major_lecture` text,
                                              PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcs_graduation_requirement`
--

LOCK TABLES `gcs_graduation_requirement` WRITE;
/*!40000 ALTER TABLE `gcs_graduation_requirement` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcs_graduation_requirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcs_lecture`
--

DROP TABLE IF EXISTS `gcs_lecture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gcs_lecture` (
                               `id` int NOT NULL AUTO_INCREMENT,
                               `year` varchar(10) NOT NULL,
                               `semester` varchar(10) NOT NULL,
                               `grade` varchar(10) NOT NULL,
                               `lecture_id` varchar(10) NOT NULL,
                               `big_type` varchar(45) NOT NULL,
                               `small_type` varchar(45) NOT NULL,
                               `major` varchar(45) NOT NULL,
                               `credit` varchar(10) NOT NULL,
                               `design_credit` varchar(10) NOT NULL,
                               `name` varchar(45) NOT NULL,
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=453 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcs_lecture`
--

LOCK TABLES `gcs_lecture` WRITE;
/*!40000 ALTER TABLE `gcs_lecture` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcs_lecture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcs_lecture_history`
--

DROP TABLE IF EXISTS `gcs_lecture_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gcs_lecture_history` (
                                       `per_id` varchar(45) NOT NULL,
                                       `year` varchar(10) NOT NULL,
                                       `semester` varchar(10) NOT NULL,
                                       `history` text NOT NULL,
                                       PRIMARY KEY (`per_id`,`year`,`semester`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcs_lecture_history`
--

LOCK TABLES `gcs_lecture_history` WRITE;
/*!40000 ALTER TABLE `gcs_lecture_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcs_lecture_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcs_required_lecture`
--

DROP TABLE IF EXISTS `gcs_required_lecture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gcs_required_lecture` (
                                        `lecture_type` varchar(45) NOT NULL,
                                        `lecture_id` varchar(45) NOT NULL,
                                        `year` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcs_required_lecture`
--

LOCK TABLES `gcs_required_lecture` WRITE;
/*!40000 ALTER TABLE `gcs_required_lecture` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcs_required_lecture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcs_similar_subject`
--

DROP TABLE IF EXISTS `gcs_similar_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gcs_similar_subject` (
                                       `oid` int NOT NULL AUTO_INCREMENT,
                                       `lectures` text NOT NULL,
                                       PRIMARY KEY (`oid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcs_similar_subject`
--

LOCK TABLES `gcs_similar_subject` WRITE;
/*!40000 ALTER TABLE `gcs_similar_subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcs_similar_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcs_special_lecture`
--

DROP TABLE IF EXISTS `gcs_special_lecture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gcs_special_lecture` (
                                       `year` varchar(10) NOT NULL,
                                       `major` varchar(30) NOT NULL,
                                       `type` varchar(30) NOT NULL,
                                       `lecture_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcs_special_lecture`
--

LOCK TABLES `gcs_special_lecture` WRITE;
/*!40000 ALTER TABLE `gcs_special_lecture` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcs_special_lecture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcs_student`
--

DROP TABLE IF EXISTS `gcs_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gcs_student` (
                               `per_id` varchar(45) NOT NULL,
                               `name` varchar(45) NOT NULL,
                               `phone` varchar(50) NOT NULL,
                               `grade` varchar(45) NOT NULL,
                               `enter_year` varchar(10) NOT NULL,
                               `major` varchar(45) NOT NULL,
                               PRIMARY KEY (`per_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcs_student`
--

LOCK TABLES `gcs_student` WRITE;
/*!40000 ALTER TABLE `gcs_student` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcs_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcs_track_requirement`
--

DROP TABLE IF EXISTS `gcs_track_requirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gcs_track_requirement` (
                                         `oid` int NOT NULL AUTO_INCREMENT,
                                         `year` varchar(30) NOT NULL,
                                         `major` varchar(30) NOT NULL,
                                         `code` varchar(30) NOT NULL,
                                         `chart_id` varchar(30) NOT NULL,
                                         `name` varchar(30) NOT NULL,
                                         `credit` varchar(30) NOT NULL,
                                         PRIMARY KEY (`oid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcs_track_requirement`
--

LOCK TABLES `gcs_track_requirement` WRITE;
/*!40000 ALTER TABLE `gcs_track_requirement` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcs_track_requirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grd_file`
--

DROP TABLE IF EXISTS `grd_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grd_file` (
                            `board_id` int NOT NULL DEFAULT '0',
                            `filename` varchar(90) NOT NULL,
                            `filelink` varchar(90) NOT NULL,
                            `id` varchar(100) NOT NULL,
                            `writer` varchar(45) DEFAULT '0',
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grd_file`
--

LOCK TABLES `grd_file` WRITE;
/*!40000 ALTER TABLE `grd_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `grd_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grd_log`
--

DROP TABLE IF EXISTS `grd_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grd_log` (
                           `id` int NOT NULL AUTO_INCREMENT,
                           `per_id` int NOT NULL,
                           `schedule_name` varchar(45) NOT NULL,
                           `success_date` datetime DEFAULT NULL,
                           `submit_date` datetime DEFAULT NULL,
                           `refuse_date` datetime DEFAULT NULL,
                           `answer_1` text,
                           `answer_2` text,
                           `answer_3` text,
                           `answer_4` text,
                           `answer_5` text,
                           `answer_6` text,
                           `answer_7` text,
                           `answer_8` text,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=659 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grd_log`
--

LOCK TABLES `grd_log` WRITE;
/*!40000 ALTER TABLE `grd_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `grd_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grd_req_students`
--

DROP TABLE IF EXISTS `grd_req_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grd_req_students` (
  `per_id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `prof_name` varchar(45) NOT NULL DEFAULT '미정',
  `capstone` tinyint NOT NULL DEFAULT '0',
  `grd_state` varchar(45) NOT NULL DEFAULT '신청접수',
  `grd_state_level` varchar(45) NOT NULL DEFAULT '대기',
  `graduation_date` varchar(45) NOT NULL DEFAULT '2018.08',
  `delay_count` tinyint NOT NULL DEFAULT '0',
  `etc` varchar(45) NOT NULL DEFAULT '불가',
  `thesis_name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`per_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grd_req_students`
--

LOCK TABLES `grd_req_students` WRITE;
/*!40000 ALTER TABLE `grd_req_students` DISABLE KEYS */;
/*!40000 ALTER TABLE `grd_req_students` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `grd_schedule`
--

    DROP TABLE IF EXISTS `grd_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `grd_schedule` (
    `schedule_id` tinyint NOT NULL AUTO_INCREMENT,
    `schedule_name` varchar(45) NOT NULL,
    `grd_state` varchar(45) NOT NULL DEFAULT '대기',
    `starting_date` datetime NOT NULL,
    `closing_date` datetime NOT NULL,
    `schedule_contents` text NOT NULL,
    PRIMARY KEY (`schedule_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grd_schedule`
--

    LOCK TABLES `grd_schedule` WRITE;
/*!40000 ALTER TABLE `grd_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `grd_schedule` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `grd_students`
--

    DROP TABLE IF EXISTS `grd_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `grd_students` (
    `per_id` int NOT NULL,
    `name` varchar(45) NOT NULL,
    `prof_name` varchar(45) NOT NULL DEFAULT '미정',
    `capstone` tinyint NOT NULL DEFAULT '0',
    `grd_state` varchar(45) NOT NULL DEFAULT '신청접수',
    `grd_state_level` varchar(45) NOT NULL DEFAULT '대기',
    `graduation_date` varchar(45) NOT NULL DEFAULT '2018.08',
    `etc` varchar(45) NOT NULL DEFAULT '불가',
    `thesis_name` varchar(45) NOT NULL DEFAULT '',
    `refuse_memo` text,
    `etc_level` varchar(45) NOT NULL DEFAULT '대기',
    `delay_count` tinyint NOT NULL DEFAULT '0',
    `delay_date` datetime DEFAULT NULL,
    PRIMARY KEY (`per_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grd_students`
--

    LOCK TABLES `grd_students` WRITE;
/*!40000 ALTER TABLE `grd_students` DISABLE KEYS */;
/*!40000 ALTER TABLE `grd_students` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `grd_userlog`
--

    DROP TABLE IF EXISTS `grd_userlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `grd_userlog` (
    `id` int NOT NULL AUTO_INCREMENT,
    `per_id` varchar(45) NOT NULL,
    `log_date` datetime NOT NULL,
    `grd_state` varchar(45) NOT NULL,
    `reason` text NOT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=8348 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grd_userlog`
--

    LOCK TABLES `grd_userlog` WRITE;
/*!40000 ALTER TABLE `grd_userlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `grd_userlog` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `grdu_certificate_data`
--

    DROP TABLE IF EXISTS `grdu_certificate_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `grdu_certificate_data` (
    `per_id` int NOT NULL,
    `requirement` varchar(45) DEFAULT NULL,
    `cer_id` varchar(45) DEFAULT NULL,
    `organization` varchar(45) DEFAULT NULL,
    `acq_date` datetime DEFAULT NULL,
    `cer_filename` text,
    `file_path` text,
    PRIMARY KEY (`per_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grdu_certificate_data`
--

    LOCK TABLES `grdu_certificate_data` WRITE;
/*!40000 ALTER TABLE `grdu_certificate_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `grdu_certificate_data` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `grdu_conference_data`
--

    DROP TABLE IF EXISTS `grdu_conference_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `grdu_conference_data` (
    `per_id` int NOT NULL,
    `conference_name` varchar(45) DEFAULT NULL,
    `requirement` varchar(45) DEFAULT NULL,
    `thesis_title` text,
    `organization` varchar(45) DEFAULT NULL,
    `open_date` datetime DEFAULT NULL,
    `thesis_filename` text,
    `proof_filename` text,
    `file_path` text,
    PRIMARY KEY (`per_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grdu_conference_data`
--

    LOCK TABLES `grdu_conference_data` WRITE;
/*!40000 ALTER TABLE `grdu_conference_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `grdu_conference_data` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `grdu_contest_data`
--

    DROP TABLE IF EXISTS `grdu_contest_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `grdu_contest_data` (
    `per_id` int NOT NULL,
    `contest_name` varchar(45) DEFAULT NULL,
    `team_type` varchar(45) DEFAULT NULL,
    `contest_content` varchar(45) DEFAULT NULL,
    `organization` varchar(45) DEFAULT NULL,
    `award_date` datetime DEFAULT NULL,
    `open_date` datetime DEFAULT NULL,
    `award_filename` text,
    `file_path` text,
    `add_filename` text,
    PRIMARY KEY (`per_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grdu_contest_data`
--

    LOCK TABLES `grdu_contest_data` WRITE;
/*!40000 ALTER TABLE `grdu_contest_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `grdu_contest_data` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `grdu_etc_state`
--

    DROP TABLE IF EXISTS `grdu_etc_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `grdu_etc_state` (
    `per_id` int NOT NULL,
    `capstone` int DEFAULT '-1',
    `certificate_submit` tinyint DEFAULT '0',
    `conference_submit` tinyint DEFAULT '0',
    `contest_submit` tinyint DEFAULT '0',
    `certi_level_int` int DEFAULT '2',
    `certi_date` datetime DEFAULT '2019-03-01 00:00:00',
    `confe_level_int` int DEFAULT '2',
    `confe_date` datetime DEFAULT '2019-03-01 00:00:00',
    `contest_level_int` int DEFAULT '2',
    `contest_date` datetime DEFAULT '2019-03-01 00:00:00',
    PRIMARY KEY (`per_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grdu_etc_state`
--

    LOCK TABLES `grdu_etc_state` WRITE;
/*!40000 ALTER TABLE `grdu_etc_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `grdu_etc_state` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `grdu_req_students`
--

    DROP TABLE IF EXISTS `grdu_req_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `grdu_req_students` (
    `per_id` int NOT NULL,
    `name` varchar(45) DEFAULT NULL,
    `prof_name` varchar(45) DEFAULT '미정',
    `capstone` int DEFAULT '0',
    `graduation_date` varchar(45) DEFAULT '2020-02',
    `etc_type` varchar(45) DEFAULT NULL,
    `major` varchar(45) DEFAULT '컴퓨터과학과',
    PRIMARY KEY (`per_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grdu_req_students`
--

    LOCK TABLES `grdu_req_students` WRITE;
/*!40000 ALTER TABLE `grdu_req_students` DISABLE KEYS */;
/*!40000 ALTER TABLE `grdu_req_students` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `grdu_schedule`
--

    DROP TABLE IF EXISTS `grdu_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `grdu_schedule` (
    `schedule_id` int NOT NULL,
    `schedule_name_int` varchar(45) DEFAULT NULL,
    `starting_date` datetime DEFAULT NULL,
    `end_date` datetime DEFAULT NULL,
    `schedule_contents` text,
    PRIMARY KEY (`schedule_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grdu_schedule`
--

    LOCK TABLES `grdu_schedule` WRITE;
/*!40000 ALTER TABLE `grdu_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `grdu_schedule` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `grdu_students`
--

    DROP TABLE IF EXISTS `grdu_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `grdu_students` (
    `per_id` int NOT NULL,
    `name` varchar(45) NOT NULL,
    `prof_name` varchar(45) DEFAULT NULL,
    `graduation_date` varchar(45) DEFAULT NULL,
    `major` varchar(45) DEFAULT '컴퓨터과학과',
    `current_state` int DEFAULT '2',
    `request` int DEFAULT '7',
    `request_action_date` datetime DEFAULT '2019-03-01 00:00:00',
    `suggest` int DEFAULT '4',
    `suggest_action_date` datetime DEFAULT '2019-03-01 00:00:00',
    `interim` int DEFAULT '2',
    `interim_action_date` datetime DEFAULT '2019-03-01 00:00:00',
    `fin` int DEFAULT '2',
    `final_action_date` datetime DEFAULT '2019-03-01 00:00:00',
    `thesis_delay` datetime DEFAULT NULL,
    `delay_count` int DEFAULT '0',
    `current` int DEFAULT '3',
    PRIMARY KEY (`per_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grdu_students`
--

    LOCK TABLES `grdu_students` WRITE;
/*!40000 ALTER TABLE `grdu_students` DISABLE KEYS */;
/*!40000 ALTER TABLE `grdu_students` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `grdu_thesis_data`
--

    DROP TABLE IF EXISTS `grdu_thesis_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `grdu_thesis_data` (
    `per_id` int NOT NULL,
    `title` text,
    `classification` varchar(45) DEFAULT NULL,
    `keyword` varchar(45) DEFAULT NULL,
    `proposal_content` text,
    `interim_filename` text,
    `interim_content` text,
    `interim_plan` text,
    `final_requirement` text,
    `final_pagenum` int DEFAULT NULL,
    `final_filename` text,
    `file_path` text,
    `interim_title` text,
    `final_title` text,
    PRIMARY KEY (`per_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grdu_thesis_data`
--

    LOCK TABLES `grdu_thesis_data` WRITE;
/*!40000 ALTER TABLE `grdu_thesis_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `grdu_thesis_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grdu_userlog`
--

DROP TABLE IF EXISTS `grdu_userlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grdu_userlog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `per_id` int DEFAULT NULL,
  `log_date` datetime DEFAULT NULL,
  `grd_state` int DEFAULT NULL,
  `user_log` int DEFAULT NULL,
  `logetc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2345 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grdu_userlog`
--

LOCK TABLES `grdu_userlog` WRITE;
/*!40000 ALTER TABLE `grdu_userlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `grdu_userlog` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `laboratory`
--

    DROP TABLE IF EXISTS `laboratory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `laboratory` (
    `id` int NOT NULL AUTO_INCREMENT,
    `lab_img` varchar(100) NOT NULL DEFAULT 'img/khkwon.jpeg',
    `lab_name` varchar(45) NOT NULL,
    `lab_location` varchar(45) NOT NULL,
    `lab_homepage` varchar(100) NOT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratory`
--

    LOCK TABLES `laboratory` WRITE;
/*!40000 ALTER TABLE `laboratory` DISABLE KEYS */;
INSERT INTO `laboratory` VALUES (3,'20180209100533-인공지능.png','인공지능','8502, 8503','http://ailab.kyonggi.ac.kr'),(10,'20180209100614-알고리즘 연구실.png','알고리즘','8504','http://algeo.kyonggi.ac.kr/'),(11,'20180209101023-데이터마이닝.png','데이터마이닝','-','https://sites.google.com/view/dmininglab/home'),(12,'20180209101542-정보보호.png','정보보호','-','http://islab.kyonggi.ac.kr/'),(13,'20210720132700-UNS.png','Smart IoT','-','https://netlab.kyonggi.ac.kr/'),(14,'20180209101651-RTOS.png','RTOS','-','http://rtos.kyonggi.ac.kr/'),(16,'20180209101912-컴퓨터그래픽스.png','컴퓨터그래픽스','8501','http://giplab.kyonggi.ac.kr/'),(17,'20190226165915-워크플로우.png','데이터&프로세스 공학','8513','http://ctrl.kyonggi.ac.kr/'),(18,'20180313161347-소프트웨어공학 연구실.png','소프트웨어공학','8306B','https://sites.google.com/view/software-safety-engineering/home'),(19,'20200925135928-차세대 보안공학 연구실.png','차세대 보안공학','8508','https://sites.google.com/view/ksel');
/*!40000 ALTER TABLE `laboratory` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `locker`
--

    DROP TABLE IF EXISTS `locker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `locker` (
    `locker_id` int NOT NULL,
    `locker_num` int NOT NULL,
    `locker_type` varchar(5) DEFAULT NULL,
    `available` varchar(15) DEFAULT NULL,
    `locker_location` int DEFAULT NULL,
    `locker_row` int DEFAULT NULL,
    PRIMARY KEY (`locker_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locker`
--

    LOCK TABLES `locker` WRITE;
/*!40000 ALTER TABLE `locker` DISABLE KEYS */;
/*!40000 ALTER TABLE `locker` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `locker_applied_students`
--

    DROP TABLE IF EXISTS `locker_applied_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `locker_applied_students` (
    `locker_num` varchar(45) DEFAULT NULL,
    `per_id` int NOT NULL,
    `name` varchar(45) DEFAULT NULL,
    `major` varchar(45) DEFAULT NULL,
    `phoneNum` varchar(45) DEFAULT NULL,
    `bank` varchar(45) DEFAULT NULL,
    `accountNum` varchar(45) DEFAULT NULL,
    `state` varchar(45) DEFAULT '신청접수(심사중)',
    `deposit` varchar(45) DEFAULT '미입금',
    PRIMARY KEY (`per_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locker_applied_students`
--

    LOCK TABLES `locker_applied_students` WRITE;
/*!40000 ALTER TABLE `locker_applied_students` DISABLE KEYS */;
/*!40000 ALTER TABLE `locker_applied_students` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `locker_assigned_students`
--

    DROP TABLE IF EXISTS `locker_assigned_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `locker_assigned_students` (
    `locker_num` varchar(45) NOT NULL,
    `per_id` int NOT NULL,
    `name` varchar(45) DEFAULT NULL,
    `major` varchar(45) DEFAULT NULL,
    `phoneNum` varchar(45) DEFAULT NULL,
    `bank` varchar(45) DEFAULT NULL,
    `accountNum` varchar(45) DEFAULT NULL,
    `state` varchar(45) DEFAULT '사용중(미반납)',
    `deposit` varchar(45) DEFAULT '보증금 미환불',
    `img_inside` varchar(45) DEFAULT '미제출',
    `img_front` varchar(45) DEFAULT '미제출',
    PRIMARY KEY (`locker_num`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locker_assigned_students`
--

    LOCK TABLES `locker_assigned_students` WRITE;
/*!40000 ALTER TABLE `locker_assigned_students` DISABLE KEYS */;
/*!40000 ALTER TABLE `locker_assigned_students` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `locker_data`
--

    DROP TABLE IF EXISTS `locker_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `locker_data` (
    `per_id` int NOT NULL,
    `name` text,
    `locker_num` varchar(45) DEFAULT NULL,
    `filename` text,
    `file_path` text,
    PRIMARY KEY (`per_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locker_data`
--

    LOCK TABLES `locker_data` WRITE;
/*!40000 ALTER TABLE `locker_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `locker_data` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `locker_data_front`
--

    DROP TABLE IF EXISTS `locker_data_front`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `locker_data_front` (
    `per_id` int NOT NULL,
    `name` text,
    `locker_num` varchar(45) DEFAULT NULL,
    `filename` text,
    `file_path` text,
    PRIMARY KEY (`per_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locker_data_front`
--

    LOCK TABLES `locker_data_front` WRITE;
/*!40000 ALTER TABLE `locker_data_front` DISABLE KEYS */;
/*!40000 ALTER TABLE `locker_data_front` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `locker_log`
--

    DROP TABLE IF EXISTS `locker_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `locker_log` (
    `student_id` varchar(45) DEFAULT NULL,
    `student_name` varchar(45) DEFAULT NULL,
    `date` varchar(45) DEFAULT NULL,
    `state` varchar(45) DEFAULT NULL,
    `method_name` varchar(45) DEFAULT NULL,
    `request_query` text
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locker_log`
--

    LOCK TABLES `locker_log` WRITE;
/*!40000 ALTER TABLE `locker_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `locker_log` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `locker_schedule`
--

    DROP TABLE IF EXISTS `locker_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `locker_schedule` (
    `schedule_id` int NOT NULL,
    `schedule_name` varchar(45) DEFAULT NULL,
    `starting_date` datetime DEFAULT NULL,
    `end_date` datetime DEFAULT NULL,
    `schedule_contents` text,
    PRIMARY KEY (`schedule_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locker_schedule`
--

    LOCK TABLES `locker_schedule` WRITE;
/*!40000 ALTER TABLE `locker_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `locker_schedule` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `notice_boards`
--

    DROP TABLE IF EXISTS `notice_boards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `notice_boards` (
    `id` smallint unsigned NOT NULL AUTO_INCREMENT,
    `student_id` varchar(50) NOT NULL,
    `title` varchar(250) NOT NULL DEFAULT '제목 없음',
    `category` varchar(20) DEFAULT NULL,
    `views` smallint unsigned NOT NULL DEFAULT '0',
    `level` tinyint NOT NULL DEFAULT '0',
    `currentStatus` tinyint NOT NULL DEFAULT '0',
    `last_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `content` text NOT NULL,
    `student_name` varchar(45) NOT NULL,
    `comments_count` int NOT NULL DEFAULT '0',
    `fixed` varchar(10) DEFAULT 'false',
    PRIMARY KEY (`id`),
    KEY `student_id` (`student_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=839 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice_boards`
--

    LOCK TABLES `notice_boards` WRITE;
/*!40000 ALTER TABLE `notice_boards` DISABLE KEYS */;
/*!40000 ALTER TABLE `notice_boards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice_comments`
--

DROP TABLE IF EXISTS `notice_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice_comments` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `writer_id` varchar(50) NOT NULL,
  `writer_name` varchar(45) NOT NULL,
  `article_id` smallint unsigned NOT NULL,
  `last_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_id` (`writer_id`),
  KEY `article_id` (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice_comments`
--

LOCK TABLES `notice_comments` WRITE;
/*!40000 ALTER TABLE `notice_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `notice_comments` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `notice_file`
--

    DROP TABLE IF EXISTS `notice_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `notice_file` (
    `board_id` int NOT NULL DEFAULT '0',
    `filename` varchar(90) NOT NULL,
    `filelink` varchar(90) NOT NULL,
    `id` varchar(100) NOT NULL,
    `writer` varchar(45) DEFAULT '0',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice_file`
--

    LOCK TABLES `notice_file` WRITE;
/*!40000 ALTER TABLE `notice_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `notice_file` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `professor`
--

    DROP TABLE IF EXISTS `professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `professor` (
    `id` int NOT NULL AUTO_INCREMENT,
    `prof_img` varchar(100) NOT NULL DEFAULT 'img/khkwon.jpeg',
    `prof_name` varchar(45) NOT NULL,
    `prof_email` varchar(100) NOT NULL,
    `prof_lecture` varchar(200) NOT NULL,
    `prof_location` varchar(45) NOT NULL,
    `prof_call` varchar(45) NOT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

    LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
INSERT INTO `professor` VALUES (1,'20180209095754-권기현.jpeg','권기현','khkwon@kyonggi.ac.kr','이산수학,','8209호','031-249-9666'),(44,'20180209095853-전준철.jpg','전준철','jcchun@kyonggi.ac.kr','멀티미디어','8212호','031-249-9668'),(45,'20180209095925-김인철.jpg','김인철','kic@kyonggi.ac.kr','인공지능,','8208호','031-249-9669'),(46,'20180209095957-김광훈.png','김광훈','kwang@kyonggi.ac.kr','워크플로우,','8210호','031-249-9679'),(47,'20180220004800-이은정.jpg','이은정','ejlee@kyonggi.ac.kr','프로그래밍언어론,','8213호','031-249-9671'),(48,'20180209100101-권준희.jpeg','권준희','kwonjh@kyonggi.ac.kr','데이터베이스,','8313호','031-249-9675'),(49,'20180221125531-안진호.jpg','안진호','jhahn@kyonggi.ac.kr','분산병렬처리,','8314호','031-249-9674'),(50,'20180220004815-김남기.jpg','김남기','ngkim@kyonggi.ac.kr','컴퓨터네트워크,','8312호','031-249-9662'),(51,'20180220004827-김희열.jpg','김희열','heeyoul.kim@kyonggi.ac.kr','컴퓨터보안,','8211호','031-249-9607'),(52,'20180220162628-이병대.JPG','이병대','blee@kyonggi.ac.kr','운영체제,','8317호','031-249-9676'),(53,'20180503091726-배상원.jpg','배상원','swbae@kyonggi.ac.kr','계산이론,','8309호','031-249-9677'),(54,'20180220162639-정경용.jpg','정경용','kychung@kyonggi.ac.kr','데이터마이닝,','8320호','031-249-1382'),(55,'20180510143344-김도훈.jpg','김도훈','karmy01@kyonggi.ac.kr','네트워크보안/블록체인','8216호','031-249-1364'),(57,'20210428143902-윤원현.jpg','임현기','hlim20@kyonggi.ac.kr','인공지능, 패턴인식','제2공학관 517호','031-249-1318'),(58,'20210428145150-윤익준.jpg','윤익준',' ijyoon@kyonggi.ac.kr','센서 네트워크, 모바일프로그래밍','8116호','031-249-9642'),(59,'20210428144720-윤원현.jpg','윤원현','einstein@kgu.ac.kr','컴퓨터공학특강','8109호','031-249-1306');
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `req_answer`
--

    DROP TABLE IF EXISTS `req_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `req_answer` (
    `id` int NOT NULL AUTO_INCREMENT,
    `board_number` int NOT NULL,
    `question_number` int NOT NULL,
    `answer` varchar(300) NOT NULL,
    `user_name` varchar(45) NOT NULL,
    `user_per_id` varchar(45) NOT NULL DEFAULT '-',
    `user_grade` varchar(45) NOT NULL DEFAULT '-',
    `user_job` varchar(45) NOT NULL,
    `user_id` varchar(45) NOT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=4906 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `req_answer`
--

    LOCK TABLES `req_answer` WRITE;
/*!40000 ALTER TABLE `req_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `req_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `req_answer_files`
--

DROP TABLE IF EXISTS `req_answer_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `req_answer_files` (
  `id` varchar(100) NOT NULL,
  `original_name` varchar(200) NOT NULL,
  `real_name` varchar(300) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `board_id` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `req_answer_files`
--

LOCK TABLES `req_answer_files` WRITE;
/*!40000 ALTER TABLE `req_answer_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `req_answer_files` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `req_boards`
--

    DROP TABLE IF EXISTS `req_boards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `req_boards` (
    `id` smallint unsigned NOT NULL AUTO_INCREMENT,
    `student_id` varchar(50) NOT NULL,
    `title` varchar(255) NOT NULL DEFAULT '제목 없음',
    `views` smallint unsigned NOT NULL DEFAULT '0',
    `last_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `content` text NOT NULL,
    `starting_date` datetime NOT NULL,
    `closing_date` datetime NOT NULL,
    `level` varchar(45) NOT NULL,
    `for_who` int NOT NULL,
    `student_name` varchar(45) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `student_id` (`student_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `req_boards`
--

    LOCK TABLES `req_boards` WRITE;
/*!40000 ALTER TABLE `req_boards` DISABLE KEYS */;
/*!40000 ALTER TABLE `req_boards` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `req_question`
--

    DROP TABLE IF EXISTS `req_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `req_question` (
    `id` int NOT NULL AUTO_INCREMENT,
    `board_number` int NOT NULL,
    `question_number` int NOT NULL,
    `question_content` varchar(600) NOT NULL,
    `question_type` tinyint NOT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=349 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `req_question`
--

    LOCK TABLES `req_question` WRITE;
/*!40000 ALTER TABLE `req_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `req_question` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `req_writer_files`
--

    DROP TABLE IF EXISTS `req_writer_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `req_writer_files` (
    `board_id` int NOT NULL DEFAULT '0',
    `original_name` varchar(100) NOT NULL,
    `real_name` varchar(200) NOT NULL,
    `id` varchar(100) NOT NULL,
    `writer_id` varchar(100) NOT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `req_writer_files`
--

    LOCK TABLES `req_writer_files` WRITE;
/*!40000 ALTER TABLE `req_writer_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `req_writer_files` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

    DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `schedule` (
    `index` int NOT NULL AUTO_INCREMENT,
    `date` datetime NOT NULL DEFAULT '2018-01-01 00:00:00',
    `content` varchar(100) NOT NULL,
    PRIMARY KEY (`index`)
    ) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

    LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES (21,'2022-01-31 00:00:00','온라인 안전교육 이수');
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `slider`
--

    DROP TABLE IF EXISTS `slider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `slider` (
    `id` int NOT NULL AUTO_INCREMENT,
    `real_name` varchar(400) NOT NULL,
    `original_name` varchar(300) NOT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slider`
--

    LOCK TABLES `slider` WRITE;
/*!40000 ALTER TABLE `slider` DISABLE KEYS */;
INSERT INTO `slider` VALUES (13,'20180301051629_slider6.png','slider6.png'),(14,'20180301051645_slider5.png','slider5.png'),(15,'20180301051659_slider4.png','slider4.png'),(16,'20180301051712_slider2.png','slider2.png'),(18,'20180301051730_KakaoTalk_20180226_130752926.jpg','KakaoTalk_20180226_130752926.jpg'),(19,'20180301051735_KakaoTalk_20180226_130752519.jpg','KakaoTalk_20180226_130752519.jpg'),(20,'20180301051741_KakaoTalk_20180226_130751971.jpg','KakaoTalk_20180226_130751971.jpg'),(45,'20210204163042_ai2.jpg','ai2.jpg'),(46,'20210204163051_ai1.jpg','ai1.jpg'),(58,'20211022125234_ai_swuniv_banner.png','ai_swuniv_banner.png'),(59,'20211022125244_swuniv_banner.png','swuniv_banner.png');
/*!40000 ALTER TABLE `slider` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `text`
--

    DROP TABLE IF EXISTS `text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `text` (
    `text_id` int NOT NULL,
    `content` longtext NOT NULL,
    PRIMARY KEY (`text_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `text`
--

    LOCK TABLES `text` WRITE;
/*!40000 ALTER TABLE `text` DISABLE KEYS */;
INSERT INTO `text` VALUES (1,'<ul>\n                    <li>\n                        <div class=\"contenttitle\">주소 및 연락처</div>\n                        <ul>\n                            <li>\n                                <div class=\"contenttitle2\">주소 : (16227) 경기도 수원시 영통구 광교산로 154-42 육영관 8304호</div>\n                            </li>\n                            <li>\n                                <div class=\"contenttitle2\">연락처 : 031-249-9670 (FAX : 031-249-9673)</div>\n                            </li>\n                        </ul>\n                    </li>\n                    <li>\n                        <div class=\"contenttitle\">오시는 길</div>\n                        <ul>\n                            <li>\n                                <div class=\"contenttitle2\">캠퍼스 지도 (컴퓨터과학과 사무실)</div>\n                                <img src=\"img/cs_route.png\" alt=\"\">\n                            </li>\n                            <li>\n                                <div class=\"contenttitle2\">수원캠퍼스</div>\n                                <div id=\"map\"></div>\n                                <script>\n                                    function initMap() {\n                                        var map = new google.maps.Map(document.getElementById(\'map\'), {\n                                            center: {lat: 37.3007218, lng: 127.0392770},\n                                            zoom: 16\n                                        });\n                                        var marker = new google.maps.Marker({\n                                            position: {lat: 37.3007218, lng: 127.0392770},\n                                            map: map\n                                        });\n                                    }\n\n                                </script>\n                                <script src=\"https://maps.googleapis.com/maps/api/js?key=AIzaSyBqeRrYz4_XJFY_vA9aqDbIiuU_Zs5odVA&callback=initMap\"\n                                        async defer></script>\n                                <p>- 지하철 이용 : 신분당선 광교(경기대)역 하차 후 도보 10분</p>\n                                <p>- 버스 이용 : 경기대후문, 수원박물관 04-181 (수원방향) 또는 경기대후문 04-184 (용인방향) 하차</p>\n                                <p>- 자가용 이용 : <br>경부고속도로 : 동수원 IC에서 수원방면으로 진출 후 우회전<br>\n                                    용서고속도로 : 광교상현 IC에서 수원방면으로 진출 후 1km 직진 후 우회전</p>\n                            </li>\n                        </ul>\n                    </li>\n                </ul>'),(19,'<p class=\"0\" style=\"text-align:center\"><span style=\"word-break:keep-all\"><span style=\"text-autospace:none\"><span style=\"font-size:15.0pt\"><span style=\"font-weight:bold\">컴퓨터공학전공(컴퓨터공학부) 졸업논문 운영세칙</span></span></span></span></p>\n\n<p class=\"0\" style=\"text-align:center\"><span style=\"word-break:keep-all\"><span style=\"text-autospace:none\">&nbsp; </span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\"><span style=\"font-weight:bold\">(1) </span></span></span><span style=\"font-weight:bold\">졸업 논문 대상자</span></span></p>\n\n<p class=\"0\" style=\"margin-left:28.3pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(1-1) </span></span>이 세칙에서 정한 졸업 논문의 절차 및 심사 규칙은 다음의 학생을 대상으로 한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:28.3pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(1-1-1) </span></span>차년도 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">2</span></span>월 졸업예정인 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">4</span></span>학년 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">1</span></span>학기 학생<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:28.3pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(1-1-2) </span></span>가을 학기 복학한 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">4</span></span>학년 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">2</span></span>학기 재학생<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">,</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:28.3pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(1-1-3) 8</span></span>월 졸업예정인 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">4</span></span>학년 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">2</span></span>학기 학생</span></p>\n\n<p class=\"0\" style=\"margin-left:28.0pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(1-2) </span></span>컴퓨터공학전공(컴퓨터공학부)&nbsp;복수전공 학생도 동일한 일정과 기준을 적용한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:28.0pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(1-3) 졸업논문 심사 대상자는 컴퓨터공학기초캡스톤디자인과 컴퓨터공학심화캡스톤디자인을 모두 이수해야한다. 단, 부득이한 경우 학과교수회의를 통해 예외를 인정할 수 있다.&nbsp;<br />\n(2022년 1월 20일 신설, 2023년 8월 이전 졸업 예정자의 경우 컴퓨터공학기초캡스톤디자인 과목은 이수하지 않아도 된다.)</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\"><span style=\"font-weight:bold\">(2) </span></span></span><span style=\"font-weight:bold\">졸업 논문 진행 절차</span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(2-1) </span></span>각 단계의 구체적 일정은 매년 졸업논문 담당교수가 지정하고 별도 공지한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(2-2) </span></span>다음 각 호는 차년도 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">2</span></span>월 졸업 예정자에 준한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span style=\"letter-spacing:0.0pt\">&rarr; </span>졸업논문대상자등록신청서 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(</span></span>이하 졸업논문신청서 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">) </span></span>제출 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(3</span></span>월 중순<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">)</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span style=\"letter-spacing:0.0pt\">&rarr; </span>제안서 제출 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(3</span></span>월 말<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">)</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span style=\"letter-spacing:0.0pt\">&rarr; </span>중간보고서 제출 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(9</span></span>월 초순<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">)</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span style=\"letter-spacing:0.0pt\">&rarr; </span>최종졸업논문 제출 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(12</span></span>월 말<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">)</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span style=\"letter-spacing:0.0pt\">&rarr; </span>결과 발표 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(12</span></span>월 초<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">)</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(2-3) </span></span>다음 각 호는 차년도 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">8</span></span>월 졸업 예정자에 준한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. 4</span></span>학년 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">2</span></span>학기 복학생의 경우 다음 일정을 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">6</span></span>개월 순연하여 진행한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. </span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span style=\"letter-spacing:0.0pt\">&rarr; </span>졸업논문신청서 제출 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(3</span></span>월 중순<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">)</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span style=\"letter-spacing:0.0pt\">&rarr; </span>제안서 제출 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(3</span></span>월 말<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">) </span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span style=\"letter-spacing:0.0pt\">&rarr; </span>중간보고서 제출 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(4</span></span>월 말<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">) </span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span style=\"letter-spacing:0.0pt\">&rarr; </span>최종졸업논문 제출 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5</span></span>월 말<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">) </span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span style=\"letter-spacing:0.0pt\">&rarr; </span>결과 발표 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(6</span></span>월 초<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">)</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:38.5pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(2-4) </span></span>졸업 예정년도 전에 그 당해 년도의 조건으로 졸업 논문 심사를 통과한 경우는 그대로 인정된다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. </span></span>단<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>한 학기 이상 휴학 후 복학한 경우 과년도 졸업논문인정신청서 를 제출해야 한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. </span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(2-5) </span></span>대상자가 만족해야 하는 단계 별 요건</span></p>\n\n<p class=\"0\" style=\"margin-left:59.5pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(2-5-1) </span></span>졸업 논문 신청 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">: </span></span>졸업논문신청서 를 기한 내에 제출하여 신청하여야 졸업 논문 대상자로 등록된다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. </span></span>학과에서는 등록된 신청자를 대상으로 지도교수를 배정한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:59.5pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(2-5-2) </span></span>제안서 제출 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">: </span></span>논문 주제와 범위를 명시한 제안서 를 작성하여 지정된 기한 내에 지도교수와 면담 후 제출해야 한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. ( </span></span>제안서 및 제안면담확인서 제출<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">)</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:59.5pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(2-5-3) </span></span>중간보고서 제출 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">: </span></span>졸업 논문의 진행에 대한 중간보고서 를 지정된 기한 내에 제출하여야 한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:59.2pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(2-5-4) </span></span><span style=\"letter-spacing:-0.2pt\">최종논문 제출 </span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:-0.2pt\">: </span></span><span style=\"letter-spacing:-0.2pt\">정해진 기간까지 </span> <span style=\"letter-spacing:-0.2pt\">최종졸업논문</span> <span style=\"letter-spacing:-0.2pt\">을 제출한다</span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:-0.2pt\">. </span></span> <span style=\"letter-spacing:-0.2pt\">최종졸업논문</span> <span style=\"letter-spacing:-0.2pt\">은 지도교수와 면담하여 제출 승인을 받은 후 제출한다</span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:-0.2pt\">. (</span></span> <span style=\"letter-spacing:-0.2pt\">최종졸업논문</span> 은 파일로 온라인 제출하고 <span style=\"letter-spacing:-0.2pt\">출력한 후 지도교수 날인 제출해야 함</span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:-0.2pt\">)</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:59.4pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(2-5-5) </span></span>이상에서 정한 <span style=\"letter-spacing:-0.3pt\">기한 내에 제출을 완료하지 못한 경우 경고가 주어지며 </span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:-0.3pt\">2</span></span><span style=\"letter-spacing:-0.3pt\">회 이상 경고를 받은 자는 </span> 연기<span style=\"letter-spacing:-0.3pt\">사유서</span> <span style=\"letter-spacing:-0.3pt\">작성 후 졸업논문담당교수가 승인해야 이후 절차를 진행할 수 있다</span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:-0.3pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\"><span style=\"font-weight:bold\">(3) </span></span></span><span style=\"font-weight:bold\">졸업 논문 사정 원칙</span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(3-1) </span></span><span style=\"letter-spacing:-0.6pt\">제출된 논문의 서면 심사는 심사위원 </span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:-0.6pt\">2</span></span><span style=\"letter-spacing:-0.6pt\">인 이상이 각 </span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:-0.6pt\">10</span></span><span style=\"letter-spacing:-0.6pt\">점 만점으로 심사하고 평균을 낸다</span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:-0.6pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(3-2) </span></span>평균 점수가 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">7</span></span>점 미만인 경우는 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">2</span></span>차 구두 심사를 받아야 한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(3-3) </span></span>서면 심사의 평균 점수가 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">4</span></span>점 미만인 경우는 서면 심사에서 탈락한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(3-4) </span></span>구두 심사는 심사위원 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">3</span></span>인이 채점하는 것을 원칙으로 하고 교육과정위원회의 평가 원칙에 따라 통과 혹은 탈락을 결정한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\"><span style=\"font-weight:bold\">(4) </span></span></span><span style=\"font-weight:bold\">졸업논문의 형식</span></span></p>\n\n<p class=\"0\" style=\"margin-left:38.4pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(4-1) </span></span>최종졸업논문 은 경기대학교 졸업논문양식 에서 정한 파일 형식을 따라야 하며<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>표지<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>요약<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>목차<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>서론<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>본론<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>결론<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>참고문헌을 포함하여야 한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. </span></span>지정된 양식을 따르지 않은 논문은 심사 대상에서 제외된다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:28.0pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(4-2) </span></span>구현 논문으로 진행할 수 있으며<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>다음과 같은 경우 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">2</span></span>차 심사를 받아야 한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span style=\"letter-spacing:0.0pt\">&rarr; </span>전공 졸업자로서 수준에 미달한 경우</span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span style=\"letter-spacing:0.0pt\">&rarr; </span>타인의 시스템을 카피한 경우</span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(4-3) </span></span>조사 논문으로 진행할 수 있으며<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>다음과 같은 경우 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">2</span></span>차 심사를 받아야 한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span style=\"letter-spacing:0.0pt\">&rarr; </span>타인의 논문이나 인터넷 상의 자료를 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">50% </span></span>이상 도용한 경우</span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span style=\"letter-spacing:0.0pt\">&rarr; </span>본인의 독자적인 의견이나 결론의 도출 없는 사실 및 정보의 나열인 경우</span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\"><span style=\"font-weight:bold\">(5) </span></span></span><span style=\"font-weight:bold\">졸업논문자격 대체 인정</span></span></p>\n\n<p class=\"0\" style=\"margin-left:38.6pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-1) </span></span>일정 수준 이상의 전공 능력을 인정받은 졸업 예정자에 대해서는 졸업논문 자격을 대체인정 할 수 있다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. </span></span>다음 각 호에 해당하는 학생은 졸업논문자격 대체인정 대상자가 된다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-1-1) </span></span>일정 수준 이상의 전공 자격증을 취득한 자</span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-1-2) </span></span>전공 관련 전국 규모 대회에서 수상한 경력이 있는 자</span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-1-3) </span></span>전공 관련 전국 규모 학술대회에서 논문을 발표한 자</span></p>\n\n<p class=\"0\" style=\"margin-left:39.8pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\"><span style=\"color:#0059ff\">(5-2) </span></span></span><span style=\"color:#0059ff\">졸업논문자격 대체는 전공필수 과목인 컴퓨터공학심화캡스톤디자인(기존 컴퓨터공학캡스톤디자인)&nbsp;과목을 이수한 경우에만 인정된다</span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\"><span style=\"color:#0059ff\">. (2018</span></span></span><span style=\"color:#0059ff\">년 </span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\"><span style=\"color:#0059ff\">1</span></span></span><span style=\"color:#0059ff\">월 </span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\"><span style=\"color:#0059ff\">22</span></span></span><span style=\"color:#0059ff\">일 신설</span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\"><span style=\"color:#0059ff\">, 2012 </span></span></span><span style=\"color:#0059ff\">교육과정 대상자에 대해 한시적으로 적용되며</span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\"><span style=\"color:#0059ff\">, 2011</span></span></span><span style=\"color:#0059ff\">년도 이전 입학생은 이 조건이 면제됨</span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\"><span style=\"color:#0059ff\">)</span></span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-3) </span></span>심사 요청 방법</span></p>\n\n<p class=\"0\" style=\"margin-left:59.0pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-3-1) </span></span>본인이 해당하는 사항에 대해 증빙서류를 구비하여 제출한 후 대체인정신청서 를 작성하여 졸업논문 지도교수와의 상담을 통해 승인을 요청한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:59.6pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-3-2) </span></span>상담 시기는 정기 상담 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(</span></span>제안서<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>중간보고서<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>최종논문 제출 전<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">) </span></span>혹은 수시 상담을 이용한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-4) </span></span>전공 자격증 대체 방법</span></p>\n\n<p class=\"0\" style=\"margin-left:59.0pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-4-1) </span></span>해당년도 심사대상 전공 자격증 목록은 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">3</span></span>월에 학과 홈페이지를 통해 공지한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">2017</span></span>년도 인정대상 목록 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">:&nbsp;</span></span></span>정보처리기사, CCNA&middot;CCNP(CISCO), 정보보호전문가(SIS) 2급 이상, SCSA&middot;SCNA 솔라리스자격증 (SUN), SQLD&middot;SQLP(데이터베이스) 자격증, OCP&nbsp;오라클(데이터베이스) 자격증, MCSE 서버자격증 (MS)</p>\n\n<p class=\"0\" style=\"margin-left:60.4pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-4-2) 8</span></span>월 졸업자의 경우 전년도에 공지한 목록의 자격증을 취득한 경우도 대체인정 대상자가 되는 것으로 한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:59.0pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-4-3) </span></span>목록에 없는 자격증에 대해서는 졸업논문 지도교수와의 상담을 통해 심사를 요청할 수 있다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:60.0pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-4-4) </span></span>자격증 사본과 대체인정신청서 를 제출하여 지도교수의 승인을 통해 졸업논문 대체 자격을 인정한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-5) </span></span>전국 규모 대회 수상에 의한 대체 방법</span></p>\n\n<p class=\"0\" style=\"margin-left:59.3pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-5-1) </span></span>전국 규모 대회에서 팀 또는 개인으로 본상 이상<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(</span></span>장려상 제외<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">) </span></span>수상한 경우 인정한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-5-2) </span></span>시상일은 졸업논문 심사일 기준으로 최근 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">1</span></span>년 이내여야 한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:60.0pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-5-3) </span></span>시상의 경우 상장과 기타 증빙자료<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(</span></span>심사용 제출파일 등<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">) </span></span>및 대체인정신청서 를 제출하여 지도교수의 승인을 통해 졸업논문 대체 자격을 인정한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-6) </span></span>학술대회 발표에 의한 대체 방법</span></p>\n\n<p class=\"0\" style=\"margin-left:59.5pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-6-1) </span></span>전국 규모 학술대회 발표의 경우 지도교수의 지도에 의해 작성된 논문으로 대상자 본인이 주저자여야 한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. </span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:59.8pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-6-2) </span></span>졸업논문 심사 시점에서 최근 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">1</span></span>년 이내에 학술대회에서 구두<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(</span></span>또는 포스터<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">) </span></span>발표한 논문을 인정한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. </span></span>심사일 이후의 발표 예정 논문은 인정하지 않는다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. </span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:59.5pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-6-3) </span></span>학술대회 발표를 증빙할 수 있는 프로그램과 출판된 논문 사본 및 대체인정신청서 를 제출하고 지도교수의 승인을 통해 졸업논문 대체 자격을 인정한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-7) </span></span>대체인정 심사 방법</span></p>\n\n<p class=\"0\" style=\"margin-left:59.0pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-7-1) </span></span><span style=\"letter-spacing:-0.2pt\">해당하는 사항에 대한 증빙자료와 대체인정신청서 를 학과 홈페이지 졸업논문 시스템을 통해 제출한다</span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:-0.2pt\">. </span></span><span style=\"letter-spacing:-0.2pt\">제출 시 인정 시기와 요건을 본인이 직접 확인해야 한다</span><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:-0.2pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:59.5pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-7-2) </span></span>대체인정신청서 를 출력하여 상담 후 날인 제출해야 한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. </span></span>단<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>사정에 의해 면담이 어려운 경우 온라인 승인이나 도장 날인 등 다른 방법으로 승인할 수 있다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:59.6pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-7-2) </span></span>상담 시기는 정기 상담 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(</span></span>제안서<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>중간보고서<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>최종논문 제출 전<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">) </span></span>혹은 수시 상담을 이용한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:59.2pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-7-3) </span></span>대체인정 승인을 받은 이후의 졸업논문 진행 절차는 면제된다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. </span></span>그러나 승인 이전에는 절차에 따라 제안서<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>중간보고서<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>최종논문 제출을 진행해야 한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:59.2pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(5-7-4) </span></span>자격증 및 학술대회 발표에 의한 대체 신청은 최종논문 마감일 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">2</span></span>주전에 완료되어야 한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\"><span style=\"font-weight:bold\">(6) </span></span></span><span style=\"font-weight:bold\">학과의 운영</span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(6-1) </span></span>졸업논문 진행 교수는 매학기 시작과 함께 학과교수회의에서 결정한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. </span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:38.2pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(6-2) </span></span>졸업논문 지도교수는 졸업논문 신청자에 대해 졸업논문 진행교수가 정한 원칙에 따라 배정하고 제안서 제출기한 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">1</span></span>주일 이전에 공지한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:38.6pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(6-3) </span></span>기타 졸업논문의 진행에 관한 사정원칙의 변경 및 결정을 요하는 사항은 프로그램운영위원회에서 결정한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:38.0pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(6-4) </span></span>졸업예정자가 위 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">2</span></span>항 및 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">3</span></span>항의 절차에서 지연 또는 미비의 사유가 발생한 경우 연기<span style=\"letter-spacing:-0.3pt\">사유서</span> 를 작성하여 졸업논문 진행교수의 승인을 받아야 하며<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">, </span></span>당해년도 졸업논문 진행교수의 결정에 의해 해당 학기 졸업논문 탈락 또는 졸업논문 서면 심사 감점을 적용할 수 있다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:38.1pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(6-5) </span></span>매 학기 학과교수회의의 심사를 통하여 일정 수준 이상의 전공 능력을 인정받은 졸업 예정자에 대해서는 졸업논문자격을 대체 인정 할 수 있다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. </span></span>졸업논문자격 대체 인정은 위 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">5</span></span>항에서 정한바와 같다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. </span></span></span></p>\n\n<p class=\"0\" style=\"margin-left:38.6pt\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(6-6) </span></span>졸업논문은 학과 홈페이지의 <u style=\"text-underline:#000000 single\">졸업논문 온라인 시스템</u>을 통하여 제출 및 승인을 진행하게 되며 대상자는 졸업논문의 공지사항과 일정을 확인하고 그에 따라 졸업논문 진행 절차의 요건을 만족해야 한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. </span></span>대상자가 졸업논문 온라인 시스템에서 요구되는 일정과 요건을 만족하지 못한 경우 졸업논문 심사 대상에서 제외된다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">. (2018</span></span>년 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">1</span></span>월 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">22</span></span>일 신설<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">)</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\"><span style=\"font-weight:bold\">(7) </span></span></span><span style=\"font-weight:bold\">규정의 적용</span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(7-1) 2018</span></span>년 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">1</span></span>월 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">22</span></span>일 학과교수회의의 의결에 따라 개정한다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">(7-2) </span></span>이 규정은 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">2018</span></span>년 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">3</span></span>월부터 적용되며 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">2018</span></span>년 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">8</span></span>월 졸업자부터 유효하다<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">.</span></span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\">&nbsp; </span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span style=\"font-weight:bold\">졸업논문 심사 양식</span></span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">[</span></span>졸업논문 양식 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">1</span></span>번<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">] </span></span>졸업논문신청서 </span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">[</span></span>졸업논문 양식 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">2</span></span>번<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">] </span></span>제안서 </span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">[</span></span>졸업논문 양식 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">3</span></span>번<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">] </span></span>중간보고서 </span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">[</span></span>졸업논문 양식 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">4</span></span>번<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">] </span></span>최종논문 </span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">[</span></span>졸업논문 양식 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">5</span></span>번<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">] </span></span>과년도 졸업논문인정신청서 </span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">[</span></span>졸업논문 양식 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">6</span></span>번<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">] </span></span>제안면담확인서 </span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">[</span></span>졸업논문 양식 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">7</span></span>번<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">] </span></span>대체인정신청서 </span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">[</span></span>졸업논문 양식 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">8</span></span>번<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">] </span></span>졸업논문심사표 </span></p>\n\n<p class=\"0\"><span style=\"text-autospace:none\"><span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">[</span></span>졸업논문 양식 <span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">9</span></span>번<span lang=\"EN-US\" style=\"font-family:돋움\"><span style=\"letter-spacing:0.0pt\">] </span></span>연기<span style=\"letter-spacing:-0.3pt\">사유서</span> </span></p>\n\n<p>- 졸업논문 양식 1-4번은 학과 홈페이지에 직접입력하므로 별도의 양식파일 불요</p>\n\n<p>- 졸업논문 양식 5, 6, 8, 9번 양식은 과사에 문의</p>\n\n<p>- 졸업논문 양식 7번은 공지사항의 졸업논문 대체인정 게시물을 확인</p>\n'),(56,'<ul>\n	<li>\n	<p>컴퓨터와 소프트웨어는 4차 산업혁명의 시대에 사회의 모든 부분을 구성하고 담당하고 있습니다. 컴퓨터공학전공(컴퓨터공학부)은&nbsp;이러한 컴퓨터와 소프트웨어를 다루는 능력을 교육하여 미래 지능형 사회를 이끌어갈 인재를 양성합니다. 정부와 기업, 가정, 사회와 개인 생활의 모든 분야에서 소프트웨어는 핵심적인 역할을 하고 있습니다. 소프트웨어 개발자는 이러한 소프트웨어를 개발하고 관리하고 운영하는 역할을 하는 미래 사회의 핵심 인력입니다.</p>\n\n	<p>▶ 진로</p>\n\n	<ol style=\"list-style: disc\">\n		<li>소프트웨어 개발자 : 미래사회를 이끌어갈 소프트웨어를 개발하는 전문 엔지니어</li>\n		<li>소프트웨어 산업 기업체 종사자 : 스마트팩토리, 스마트자동차, 스마트헬스케어 등 다양한 분야의 산업체에 취업하여 사회의 발전을 위해 일하는 전문 엔지니어</li>\n		<li>소프트웨어 분야 창업 : 제품 및 서비스를 기획하고 개발하는 기업을 직접 운영하는 사업가</li>\n		<li>교육자 : 초중등 학교와 일반인 대상의 소프트웨어 교육을 담당할 교육분야 전문가</li>\n		<li>공무원 : 국가 전산 업무를 담당하고 소프트웨어 분야의 정책을 담당하는 기술 공무원</li>\n	</ol>\n\n	<p>▶ 학과사무실</p>\n\n	<ol style=\"list-style: disc\">\n		<li>위치 : 8강의동 3층 8305호</li>\n		<li>전화번호 : 031-249-9670 (FAX : 031-249-9673)</li>\n		<li>홈페이지 : http://cs.kyonggi.ac.kr</li>\n		<li>학과이메일 : aics8305@kyonggi.ac.kr</li>\n	</ol>\n	</li>\n</ul>\n\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>\n'),(57,'<p>컴퓨터공학전공(컴퓨터공학부)이&nbsp;1980년도에 문을 연지 벌써 30년이 되었습니다. 그동안 2300여명의 졸업생을 배출하면서 컴퓨터 관련 전공으로는 규모가 전국에서 몇 손가락 안에 드는 학과가 되었습니다. 우리 학과는 열 한 분의 교수님들과 400여 명의 학생들이 우의와 신뢰로 배움과 가르침에 매진하고 있습니다.</p>\n\n<div class=\"contenttitle2\">▶ 학생 현황 (2016년 2월 현재)</div>\n<style type=\"text/css\">.tg {\n                                    border-collapse: collapse;\n                                    border-spacing: 0;\n                                }\n\n                                .tg td {\n                                    font-family: Arial, sans-serif;\n                                    font-size: 14px;\n                                    padding: 5px 10px;\n                                    border-style: solid;\n                                    border-width: 1px;\n                                    overflow: hidden;\n                                    word-break: normal;\n                                }\n\n                                .tg th {\n                                    font-family: Arial, sans-serif;\n                                    font-size: 14px;\n                                    font-weight: normal;\n                                    padding: 5px 10px;\n                                    border-style: solid;\n                                    border-width: 1px;\n                                    overflow: hidden;\n                                    word-break: normal;\n                                }\n\n                                .tg .tg-s6z2 {\n                                    text-align: center\n                                }\n\n                                .tg .tg-j4kc {\n                                    background-color: #efefef;\n                                    text-align: center\n                                }\n</style>\n<table class=\"tg\">\n	<tbody>\n		<tr>\n			<th class=\"tg-j4kc\" colspan=\"3\">1학년</th>\n			<th class=\"tg-j4kc\" colspan=\"3\">2학년</th>\n			<th class=\"tg-j4kc\" colspan=\"3\">3학년</th>\n			<th class=\"tg-j4kc\" colspan=\"3\">4학년</th>\n			<th class=\"tg-j4kc\" colspan=\"3\">계</th>\n		</tr>\n		<tr>\n			<td class=\"tg-s6z2\">남</td>\n			<td class=\"tg-s6z2\">여</td>\n			<td class=\"tg-s6z2\">계</td>\n			<td class=\"tg-s6z2\">남</td>\n			<td class=\"tg-s6z2\">여</td>\n			<td class=\"tg-s6z2\">계</td>\n			<td class=\"tg-s6z2\">남</td>\n			<td class=\"tg-s6z2\">여</td>\n			<td class=\"tg-s6z2\">계</td>\n			<td class=\"tg-s6z2\">남</td>\n			<td class=\"tg-s6z2\">여</td>\n			<td class=\"tg-s6z2\">계</td>\n			<td class=\"tg-s6z2\">남</td>\n			<td class=\"tg-s6z2\">여</td>\n			<td class=\"tg-s6z2\">계</td>\n		</tr>\n		<tr>\n			<td class=\"tg-s6z2\">73</td>\n			<td class=\"tg-s6z2\">28</td>\n			<td class=\"tg-s6z2\">101</td>\n			<td class=\"tg-s6z2\">74</td>\n			<td class=\"tg-s6z2\">21</td>\n			<td class=\"tg-s6z2\">95</td>\n			<td class=\"tg-s6z2\">77</td>\n			<td class=\"tg-s6z2\">27</td>\n			<td class=\"tg-s6z2\">104</td>\n			<td class=\"tg-s6z2\">82</td>\n			<td class=\"tg-s6z2\">25</td>\n			<td class=\"tg-s6z2\">107</td>\n			<td class=\"tg-s6z2\">306</td>\n			<td class=\"tg-s6z2\">101</td>\n			<td class=\"tg-s6z2\">407</td>\n		</tr>\n	</tbody>\n</table>\n\n<ul style=\"list-style: disc\"><br />\n	<li>\n	<div class=\"contenttitle2\">1979년 9월 22일 경기대학교 수원본교에 전자계산학과 40명 신설</div>\n	</li>\n	<li>\n	<div class=\"contenttitle2\">1983년 9월 8일 전자계산학과 30명 증원(총 70명)</div>\n	</li>\n	<li>\n	<div class=\"contenttitle2\">1991년 10월 22일 경기대학교 수원본교에 전자계산학과 야간 신설</div>\n	</li>\n	<li>\n	<div class=\"contenttitle2\">1992년 7월 28일 대학원 석사과정에 전자계산학과 신설</div>\n	</li>\n	<li>\n	<div class=\"contenttitle2\">1995년 10월 18일 대학원 박사과정에 전자계산학과 신설</div>\n	</li>\n	<li>\n	<div class=\"contenttitle2\">1997년 11월 5일 대학원 박사과정에 전자계산학과 신설</div>\n	</li>\n	<li>\n	<div class=\"contenttitle2\">2003년 5월 전자계산학과에서 컴퓨터과학과로 전공 명칭 변경</div>\n	</li>\n	<li>\n	<div class=\"contenttitle2\">2007년 3월 공학인증 시작</div>\n	</li>\n	<li>\n	<div class=\"contenttitle2\">2017년 3월 이공대학 컴퓨터과학과로 소속 변경</div>\n	</li>\n	<li>\n	<div class=\"contenttitle2\">2018년 3월 융합과학대학 컴퓨터공학부로 소속 변경 (신입생 정원 150명)</div>\n	</li>\n</ul>\n'),(58,'<div class=\"contenttitle2\">&nbsp;</div>\n\n<div class=\"contenttitle2\">1) 수요 지향적 융&middot;복합형 소프트웨어 엔지니어 양성</div>\n\n<p>- 컴퓨터 과학의 기본개념과 구성원리 이해<br />\n- 프로그래밍 능력과 도구의 활용 능력<br />\n- 수요지향적 기술의 습득과 실무능력 향상<br />\n- 다양한 분야와의 융&middot;복합을 통한 새로운 소프트웨어 지식 창출</p>\n\n<hr style=\"border: 1px solid lightgray;\" />\n<div class=\"contenttitle2\">2) 국제적 경쟁력을 갖춘 글로벌 우수 인재 양성</div>\n\n<p>- 국제적인 수준의 프로그래밍 능력<br />\n- 국제적인 IT 관련 표준과 용어의 이해<br />\n- 국제적 표준을 이용한 설계 및 기술적 표현 능력 향상</p>\n\n<hr style=\"border: 1px solid lightgray;\" />\n<div class=\"contenttitle2\">3) 자기 주도적 실용 IT 전문가 양성</div>\n\n<p>- 문제해결 능력과 설계능력의 함양<br />\n- 자기주도적 프로젝트 기획/설계/구현 능력<br />\n- 팀 단위의 작업을 통한 팀위크와 리더십의 훈련<br />\n- 발표능력과 문서작성 능력의 향상</p>\n\n<hr style=\"border: 1px solid lightgray;\" />'),(59,'<p>컴퓨터공학전공(컴퓨터공학부)은&nbsp;최고수준의 개인용 컴퓨터와 프로젝터 환경을 갖춘 4개의 실습실을 보유하고 있으며, 반 이상의 수업이 실습실에서 진행됩니다. 또한 팀프로젝트 진행을 위한 회의 공간과 세미나실을 제공하여 활발한 커뮤니케이션을 통한 창의적 인재를 양성하는데 힘을 쏟고 있습니다.</p>\n\n<ul>\n	<li>\n	<div class=\"contenttitle2\">▶ 학과전용 실습실 현황</div>\n	</li>\n</ul>\n\n<p>\n<style type=\"text/css\">.tg {\n	border-collapse: collapse;\n	border-spacing: 0;\n}\n\n.tg td {\n	font-size: 14px;\n	padding: 10px 5px;\n	border-style: solid;\n	border-width: 1px;\n	overflow: hidden;\n	word-break: normal;\n}\n\n.tg th {;\n	font-size: 14px;\n	font-weight: normal;\n	padding: 10px 5px;\n	border-style: solid;\n	border-width: 1px;\n	overflow: hidden;\n	word-break: normal;\n}\n\n.tg .tg-s6z2 {\n	text-align: center\n}\n\n.tg .tg-baqh {\n	text-align: center;\n	vertical-align: top\n}\n\n.tg .tg-j4kc {\n	background-color: #efefef;\n	text-align: center\n}\n</style>\n</p>\n\n<table class=\"tg\" style=\"table-layout: fixed; width: 581px\">\n	<colgroup>\n		<col style=\"width: 55px\" />\n		<col style=\"width: 84px\" />\n		<col style=\"width: 246px\" />\n		<col style=\"width: 75px\" />\n		<col style=\"width: 121px\" />\n	</colgroup>\n	<tbody>\n		<tr>\n			<th class=\"tg-j4kc\">번호</th>\n			<th class=\"tg-j4kc\">호실</th>\n			<th class=\"tg-j4kc\">위치</th>\n			<th class=\"tg-j4kc\">PC대수</th>\n			<th class=\"tg-j4kc\">기타</th>\n		</tr>\n		<tr>\n			<td class=\"tg-s6z2\">1</td>\n			<td class=\"tg-s6z2\">8308</td>\n			<td class=\"tg-s6z2\">8강의동 3층</td>\n			<td class=\"tg-s6z2\">50</td>\n			<td class=\"tg-s6z2\">야간 개방</td>\n		</tr>\n		<tr>\n			<td class=\"tg-s6z2\">2</td>\n			<td class=\"tg-s6z2\">8001</td>\n			<td class=\"tg-s6z2\">8강의동 B1층</td>\n			<td class=\"tg-s6z2\">45</td>\n			<td class=\"tg-s6z2\">&nbsp;</td>\n		</tr>\n		<tr>\n			<td class=\"tg-baqh\">3</td>\n			<td class=\"tg-baqh\">8510</td>\n			<td class=\"tg-baqh\">8강의동 5층</td>\n			<td class=\"tg-baqh\">40</td>\n			<td class=\"tg-baqh\">&nbsp;</td>\n		</tr>\n		<tr>\n			<td class=\"tg-baqh\">4</td>\n			<td class=\"tg-baqh\">8504</td>\n			<td class=\"tg-baqh\">8강의동 5층</td>\n			<td class=\"tg-baqh\">25</td>\n			<td class=\"tg-baqh\">개방 실습실</td>\n		</tr>\n	</tbody>\n</table>\n\n<hr style=\"border: solid 1px lightgray;\" />\n<p><img height=\"300\" src=\"img/8001.png\" width=\"500\" /></p>\n\n<p><img height=\"300\" src=\"img/8308.png\" width=\"500\" /></p>\n\n<p><img height=\"300\" src=\"img/8504.png\" width=\"500\" /></p>\n\n<hr style=\"border: solid 1px lightgray;\" />\n<ul>\n	<li>\n	<div class=\"contenttitle2\">▶ 기타 실습환경</div>\n	</li>\n</ul>\n\n<p>교육과 연구를 위한 학과의 컴퓨팅 환경으로는 학과 공용으로 다수의 컴퓨터 서버, 스토리지 서버, 클러스터드 리눅스 서버를 갖추고 있으며, 연구실 별로도 각종 서버급 컴퓨터, 워크스테이션, 최신의 퍼스널 컴퓨터 및 여러 종류의 주변 기기를 보유하고 있습니다. 모든 컴퓨터는 초고속 통신망으로 인터넷에 연결되어 있으며 8강의동 전체에 무선랜이 설치되어 연구실과 강의실 어느 곳에서도 무선으로 인터넷 접속이 가능하도록 되어있습니다.</p>\n'),(60,'<p>컴퓨터공학전공(컴퓨터공학부)에서는 컴퓨터 기술의 기본이 되는 논리적 기초와 컴퓨터 시스템의 동작 원리를 학습하고 C, Java, 파이썬 등 프로그램을 개발하는 능력을 습득, 훈련한다. 고학년에서는 논리적이고 체계적인 사고를 이용한 인공지능, 데이터베이스, 멀티미디어, 소프트웨어공학 등 응용 분야 기술의 습득한다. 4년 교육과정에서 모든 학생들이 5개 이상의 과목 프로젝트를 수행하여 다양한 분야의 설계와 개발을 경험한다. 그리고 전공 교육과정 전체를 이용한 캡스톤 프로젝트 개발과 현장실습교육을 통한 실무적인 능력을 습득한다.</p>\n'),(61,'                 <ul>\n                            <div class=\"contenttitle2\">실습실 야간개방 및 프로그래밍 QnA 운영</div>\n                            <li>\n                                학과에서는 8308호 실습실의 야간 (17:00-22:00) 시간에 개방하여 운영하고 있습니다.<br>\n                                학생들의 과제와 학습을 위해 근무자 배치하여 운영하고 있으며,2017년 2학기부터는 프로그래밍 QnA 형태로 간단한 과제 지원 등을 함께 할 예정입니다.\n                            </li>\n                            <hr style=\"border: solid 0.1px lightgray;\"/>\n                            <div class=\"contenttitle2\">8504호 실습실 개방 운영</div>\n                            <li>\n                                재학생들의 프로그래밍 과제와 학습을 위해 8504호 실습실을 주간 시간에 개방하여 운영하고 있습니다. 이 실습실은 수업 배정 없이 운영되며, 2017년 여름에\n                                환경 개선 및 PC 교체로 우수한 환경을 구축하였습니다.\n                                이외에 컴퓨터과학과에서는 다양한 학습활동 지원 프로그램을 운영하고 있습니다. 학과 홈페이지의 공지사항과 신청및접수 기능을 이용하여 참여하실 수 있습니다.\n                            </li>\n                            <hr style=\"border: solid 0.1px lightgray;\"/>\n                            <li>\n                                <div class=\"contenttitle2\">피어튜터링 [비교과프로그램]</div>\n                                - MSC 및 전공과목을 주제<br>\n                                - 튜터와 3인 이상 튜티로 구성된 팀으로 학기중 10회 이상 튜터링 학습 활동 진행<br>\n                                - 튜터 장학금 및 참가자 KGU 포인트 지급<br>\n                                - 공학인증지원센터 주관<br>\n                            </li>\n                            <hr style=\"border: solid 0.1px lightgray;\"/>\n                            <li>\n                                <div class=\"contenttitle2\">KCPC 프로그래밍경진대회</div>\n                                - 컴퓨터과학과에서는 매년 11월 재학생 대상으로 대회 개최<br>\n                                - 2017년부터는 5월말에 1학년 대상의 C, 2학년 대상의 자바 프로그래밍 경진대회 개최<br>\n                                - 2시간 가량 대회 진행, 시상<br>\n                            </li>\n                            <hr style=\"border: solid 0.1px lightgray;\"/>\n                            <li>\n                                <div class=\"contenttitle2\">캡스톤설계전시회</div>\n                                - 4학년 1학기 캡스톤설계 교과목 결과물의 전시회 개최 (매년 5월말)<br>\n                                - 팀별로 개발된 캡스톤설계 프로젝트를 시연과 포스터로 전시함<br>\n                            </li>\n                            <hr style=\"border: solid 0.1px lightgray;\"/>\n                            <li>\n                                <div class=\"contenttitle2\">우수학생작품발표회</div>\n                                - 재학생(고학년 중심)의 우수한 작품을 한자리에 모아 발표하는 자리로 매년 11월 개최<br>\n                                - 동아리, 팀활동, 교과목 프로젝트 등을 대상으로 심사하여 발표자 선정<br>\n                            </li>\n                            <hr style=\"border: solid 0.1px lightgray;\"/>\n                            <li>\n                                <div class=\"contenttitle2\">방학집중캠프</div>\n                                - 하계 및 동계 방학 기간에 5일 40시간의 집중 캠프를 진행<br>\n                                - 프로그래밍 연습과 훈련을 위한 프로그래밍 캠프<br>\n                                - IoT, 앱/웹 개발 등 실무 기술 교육 캠프<br>\n                                - 방학 초 또는 개학 전 시기에 모집하여 진행<br>\n                                - 2015~2017년 8회 진행 (교내 특성화 프로그램)<br>\n                            </li>\n                            <hr style=\"border: solid 0.1px lightgray;\"/>\n                            <li>\n                                <div class=\"contenttitle2\">리터니캠프</div>\n                                - 복학생 대상의 학업적응 지원 프로그램<br>\n                                - 개학 전 시기에 복학생 대상으로 수강신청 안내, 수업 준비, 프로그래밍 교육 등 프로그램 운영<br>\n                                - 2017년 2월 첫 시행<br>\n                            </li>\n                            <hr style=\"border: solid 0.1px lightgray;\"/>\n                            <li>\n                                <div class=\"contenttitle2\">자격증준비반 (SQLD, ADsP)</div>\n                                - 학기말 년 2회로 SQLD 자격증 준비반 프로그램 진행<br>\n                                - 3,4학년 대상<br>\n                                - 2015, 2016년 5회 운영<br>\n                            </li>\n                            <hr style=\"border: solid 0.1px lightgray;\"/>\n                        </ul>'),(100,'국민은행'),(101,'123-4567-890'),(102,'오픈채팅 https://open.kakao.com');
/*!40000 ALTER TABLE `text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `track_subject`
--

DROP TABLE IF EXISTS `track_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `track_subject` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sub_code` varchar(45) DEFAULT NULL,
  `sub_grade` int DEFAULT NULL,
  `sub_class_ex` varchar(45) DEFAULT NULL,
  `sub_semester` int DEFAULT NULL,
  `sub_title` varchar(45) DEFAULT NULL,
  `credit` int DEFAULT NULL,
  `found_year` int DEFAULT NULL,
  `repeal_year` int DEFAULT NULL,
  `track_code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track_subject`
--

LOCK TABLES `track_subject` WRITE;
/*!40000 ALTER TABLE `track_subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `track_subject` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `track_user`
--

    DROP TABLE IF EXISTS `track_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `track_user` (
    `id` varchar(50) NOT NULL,
    `per_id` varchar(50) NOT NULL,
    `name` varchar(50) NOT NULL,
    `track_ex` tinyint NOT NULL,
    `adm_year` int NOT NULL,
    `comp_sem` int NOT NULL DEFAULT '0',
    `last_modi_year` int DEFAULT NULL,
    `log_date` datetime NOT NULL DEFAULT '2020-01-01 00:00:00',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track_user`
--

    LOCK TABLES `track_user` WRITE;
/*!40000 ALTER TABLE `track_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `track_user` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `track_user_subject`
--

    DROP TABLE IF EXISTS `track_user_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `track_user_subject` (
    `id` varchar(50) NOT NULL,
    `sub_id` varchar(10) NOT NULL,
    `year` int NOT NULL,
    `sem` int NOT NULL,
    `grade_sem` varchar(10) NOT NULL,
    PRIMARY KEY (`id`,`sub_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track_user_subject`
--

    LOCK TABLES `track_user_subject` WRITE;
/*!40000 ALTER TABLE `track_user_subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `track_user_subject` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `uploaded_file`
--

    DROP TABLE IF EXISTS `uploaded_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `uploaded_file` (
    `id` int NOT NULL AUTO_INCREMENT,
    `user_id` varchar(100) NOT NULL,
    `uploadFile` varchar(100) NOT NULL,
    `newFileName` varchar(100) NOT NULL,
    `upload_time` date NOT NULL,
    `savePath` varchar(100) NOT NULL,
    `folder` varchar(100) NOT NULL,
    `uploaded` varchar(10) NOT NULL DEFAULT 'false',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uploaded_file`
--

    LOCK TABLES `uploaded_file` WRITE;
/*!40000 ALTER TABLE `uploaded_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `uploaded_file` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `user`
--

    DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `user` (
    `id` varchar(45) NOT NULL,
    `password` varchar(100) NOT NULL DEFAULT '-',
    `name` varchar(45) NOT NULL DEFAULT '-',
    `gender` varchar(10) NOT NULL DEFAULT '-',
    `birth` varchar(45) NOT NULL DEFAULT '-',
    `type` varchar(45) NOT NULL DEFAULT '-',
    `email` varchar(100) NOT NULL DEFAULT '-',
    `phone` varchar(45) NOT NULL DEFAULT '-',
    `last_login` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
    `hope_type` varchar(45) NOT NULL DEFAULT '-',
    `reg_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
    `major` varchar(45) NOT NULL DEFAULT '-',
    `per_id` varchar(45) NOT NULL DEFAULT '-',
    `why` varchar(100) NOT NULL DEFAULT '-',
    `grade` varchar(10) NOT NULL DEFAULT '-',
    `state` varchar(10) NOT NULL DEFAULT '-',
    `myhomeid` varchar(45) NOT NULL DEFAULT '-',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

    LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `user_ai`
--

    DROP TABLE IF EXISTS `user_ai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `user_ai` (
    `id` varchar(45) NOT NULL,
    `name` varchar(45) NOT NULL,
    `type` varchar(45) NOT NULL,
    `major` varchar(45) NOT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_ai`
--

    LOCK TABLES `user_ai` WRITE;
/*!40000 ALTER TABLE `user_ai` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_ai` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `usertype`
--

    DROP TABLE IF EXISTS `usertype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `usertype` (
    `class_type` varchar(45) NOT NULL,
    `type_name` varchar(45) NOT NULL,
    `board_level` int NOT NULL,
    `p3_level` int NOT NULL,
    `thesis_level` int NOT NULL,
    `resv_level` int NOT NULL,
    `blog_level` int NOT NULL,
    `table_level` int NOT NULL,
    `for_header` varchar(45) NOT NULL,
    PRIMARY KEY (`type_name`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usertype`
--

    LOCK TABLES `usertype` WRITE;
/*!40000 ALTER TABLE `usertype` DISABLE KEYS */;
INSERT INTO `usertype` VALUES ('Admin','P3관리자',5,0,0,0,0,0,'관리자'),('SmallUser','게스트',9,0,0,0,0,0,'손님'),('Admin','관리자',0,0,0,0,0,0,'관리자'),('BigUser','교수1',1,0,0,0,0,0,'교수'),('BigUser','교수2',3,0,0,0,0,0,'교수'),('SmallUser','구분변경희망자',8,0,0,0,0,0,'기타'),('SmallUser','기타',8,0,0,0,0,0,'기타'),('BigUser','대학원생',4,0,0,0,0,0,'학생'),('BigUser','복수전공생',6,0,0,0,0,0,'학생'),('Admin','사물함관리자',5,0,0,0,0,0,'관리자'),('SmallUser','입학예정자',8,0,0,0,0,0,'기타'),('BigUser','조교',2,0,0,0,0,0,'조교'),('Admin','졸업논문관리자',2,0,0,0,0,0,'관리자'),('BigUser','타과생',7,0,0,0,0,0,'학생'),('SmallUser','학부모',8,0,0,0,0,0,'학부모'),('BigUser','학부생',5,0,0,0,0,0,'학생'),('Admin','홈페이지관리자',0,0,0,0,0,0,'관리자');
/*!40000 ALTER TABLE `usertype` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `v2_text`
--

    DROP TABLE IF EXISTS `v2_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `v2_text` (
    `id` int NOT NULL,
    `major` varchar(10) NOT NULL,
    `content` longtext NOT NULL,
    PRIMARY KEY (`id`,`major`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `v2_text`
--

    LOCK TABLES `v2_text` WRITE;
/*!40000 ALTER TABLE `v2_text` DISABLE KEYS */;
INSERT INTO `v2_text` VALUES (11,'ai','<ul>\n	<li>\n	<p>인공지능 기술은 4차 산업혁명 시대를 이끄는 핵심 기술입니다. 인공지능학과는 혁신적인 인공지능 기술 중심의 교육을 통해 정부와 기업, 사회의 모든 분야에서 핵심적인 역할을 할 수 있는 인재 양성에 최선을 다합니다. 또한 인공지능 분야의 산업체와의 협업, 현업에서의 전문 기술 교육을 통해 미래 지능형 사회를 이끌어갈 인재를 양성합니다.</p>\n\n	<p>▶ 진로</p>\n\n	<ol>\n		<li>인공지능 SW 개발자 : 미래 인공지능 사회를 이끌어갈 소프트웨어를 개발하는 전문 엔지니어</li>\n		<li>인공지능 산업 기업체 종사자 : 스마트팩토리, 스마트자동차, 스마트헬스케어 등 다양한 분야의 산업체에 취업하여 사회의 발전을 위해 일하는 전문 엔지니어</li>\n		<li>인공지능 분야 창업 : 인공지능 기술을 이용한 제품 및 서비스를 기획하고 개발하는 기업을 직접 운영하는 사업가</li>\n		<li>교육자 : 초중등 학교와 일반인 대상의 인공지능 교육을 담당할 교육분야 전문가</li>\n		<li>공무원 : 국가 전산 업무를 담당하고 4차 산업분야의 정책을 담당하는 기술 공무원</li>\n	</ol>\n\n	<p>▶ 학과사무실</p>\n\n	<ol>\n		<li>위치 : 8강의동 3층 8305호</li>\n		<li>전화번호 : 031-249-9670 (FAX : 031-249-9673)</li>\n		<li>홈페이지 : http://ai.kyonggi.ac.kr</li>\n	</ol>\n	</li>\n</ul>\n'),(11,'cs','<ul>\n	<li>\n	<p>컴퓨터와 소프트웨어는 4차 산업혁명의 시대에 사회의 모든 부분을 구성하고 담당하고 있습니다. 컴퓨터공학전공(컴퓨터공학부)은&nbsp;이러한 컴퓨터와 소프트웨어를 다루는 능력을 교육하여 미래 지능형 사회를 이끌어갈 인재를 양성합니다. 정부와 기업, 가정, 사회와 개인 생활의 모든 분야에서 소프트웨어는 핵심적인 역할을 하고 있습니다. 소프트웨어 개발자는 이러한 소프트웨어를 개발하고 관리하고 운영하는 역할을 하는 미래 사회의 핵심 인력입니다.</p>\n\n	<p>▶ 진로</p>\n\n	<ol>\n		<li>소프트웨어 개발자 : 미래사회를 이끌어갈 소프트웨어를 개발하는 전문 엔지니어</li>\n		<li>소프트웨어 산업 기업체 종사자 : 스마트팩토리, 스마트자동차, 스마트헬스케어 등 다양한 분야의 산업체에 취업하여 사회의 발전을 위해 일하는 전문 엔지니어</li>\n		<li>소프트웨어 분야 창업 : 제품 및 서비스를 기획하고 개발하는 기업을 직접 운영하는 사업가</li>\n		<li>교육자 : 초중등 학교와 일반인 대상의 소프트웨어 교육을 담당할 교육분야 전문가</li>\n		<li>공무원 : 국가 전산 업무를 담당하고 소프트웨어 분야의 정책을 담당하는 기술 공무원</li>\n	</ol>\n\n	<p>▶ 학과사무실</p>\n\n	<ol>\n		<li>위치 : 8강의동 3층 8305호</li>\n		<li>전화번호 : 031-249-9670 (FAX : 031-249-9673)</li>\n		<li>홈페이지 : http://cs.kyonggi.ac.kr</li>\n		<li>학과이메일 : aics8305@kyonggi.ac.kr</li>\n	</ol>\n	</li>\n</ul>\n\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>\n'),(12,'ai','<p>컴퓨터공학전공(컴퓨터공학부)이&nbsp;1980년도에 문을 연지 벌써 30년이 되었습니다. 그동안 2300여명의 졸업생을 배출하면서 컴퓨터 관련 전공으로는 규모가 전국에서 몇 손가락 안에 드는 학과가 되었습니다. 우리 학과는 열 한 분의 교수님들과 400여 명의 학생들이 우의와 신뢰로 배움과 가르침에 매진하고 있습니다.</p>\n\n<p>▶ 학생 현황 (2016년 2월 현재)</p>\n\n<table>\n	<tbody>\n		<tr>\n			<th colspan=\"3\">1학년</th>\n			<th colspan=\"3\">2학년</th>\n			<th colspan=\"3\">3학년</th>\n			<th colspan=\"3\">4학년</th>\n			<th colspan=\"3\">계</th>\n		</tr>\n		<tr>\n			<td>남</td>\n			<td>여</td>\n			<td>계</td>\n			<td>남</td>\n			<td>여</td>\n			<td>계</td>\n			<td>남</td>\n			<td>여</td>\n			<td>계</td>\n			<td>남</td>\n			<td>여</td>\n			<td>계</td>\n			<td>남</td>\n			<td>여</td>\n			<td>계</td>\n		</tr>\n		<tr>\n			<td>73</td>\n			<td>28</td>\n			<td>101</td>\n			<td>74</td>\n			<td>21</td>\n			<td>95</td>\n			<td>77</td>\n			<td>27</td>\n			<td>104</td>\n			<td>82</td>\n			<td>25</td>\n			<td>107</td>\n			<td>306</td>\n			<td>101</td>\n			<td>407</td>\n		</tr>\n	</tbody>\n</table>\n\n<ul><br />\n	<li>\n	<p>1979년 9월 22일 경기대학교 수원본교에 전자계산학과 40명 신설</p>\n	</li>\n	<li>\n	<p>1983년 9월 8일 전자계산학과 30명 증원(총 70명)</p>\n	</li>\n	<li>\n	<p>1991년 10월 22일 경기대학교 수원본교에 전자계산학과 야간 신설</p>\n	</li>\n	<li>\n	<p>1992년 7월 28일 대학원 석사과정에 전자계산학과 신설</p>\n	</li>\n	<li>\n	<p>1995년 10월 18일 대학원 박사과정에 전자계산학과 신설</p>\n	</li>\n	<li>\n	<p>1997년 11월 5일 대학원 박사과정에 전자계산학과 신설</p>\n	</li>\n	<li>\n	<p>2003년 5월 전자계산학과에서 컴퓨터과학과로 전공 명칭 변경</p>\n	</li>\n	<li>\n	<p>2007년 3월 공학인증 시작</p>\n	</li>\n	<li>\n	<p>2017년 3월 이공대학 컴퓨터과학과로 소속 변경</p>\n	</li>\n	<li>\n	<p>2018년 3월 융합과학대학 컴퓨터공학부로 소속 변경 (신입생 정원 150명)</p>\n	</li>\n</ul>\n'),(12,'cs','<p>컴퓨터공학전공(컴퓨터공학부)이&nbsp;1980년도에 문을 연지 벌써 30년이 되었습니다. 그동안 2300여명의 졸업생을 배출하면서 컴퓨터 관련 전공으로는 규모가 전국에서 몇 손가락 안에 드는 학과가 되었습니다. 우리 학과는 열 한 분의 교수님들과 400여 명의 학생들이 우의와 신뢰로 배움과 가르침에 매진하고 있습니다.</p>\n\n<p>▶ 학생 현황 (2016년 2월 현재)</p>\n\n<table>\n	<tbody>\n		<tr>\n			<th colspan=\"3\">1학년</th>\n			<th colspan=\"3\">2학년</th>\n			<th colspan=\"3\">3학년</th>\n			<th colspan=\"3\">4학년</th>\n			<th colspan=\"3\">계</th>\n		</tr>\n		<tr>\n			<td>남</td>\n			<td>여</td>\n			<td>계</td>\n			<td>남</td>\n			<td>여</td>\n			<td>계</td>\n			<td>남</td>\n			<td>여</td>\n			<td>계</td>\n			<td>남</td>\n			<td>여</td>\n			<td>계</td>\n			<td>남</td>\n			<td>여</td>\n			<td>계</td>\n		</tr>\n		<tr>\n			<td>73</td>\n			<td>28</td>\n			<td>101</td>\n			<td>74</td>\n			<td>21</td>\n			<td>95</td>\n			<td>77</td>\n			<td>27</td>\n			<td>104</td>\n			<td>82</td>\n			<td>25</td>\n			<td>107</td>\n			<td>306</td>\n			<td>101</td>\n			<td>407</td>\n		</tr>\n	</tbody>\n</table>\n\n<ul><br />\n	<li>\n	<p>1979년 9월 22일 경기대학교 수원본교에 전자계산학과 40명 신설</p>\n	</li>\n	<li>\n	<p>1983년 9월 8일 전자계산학과 30명 증원(총 70명)</p>\n	</li>\n	<li>\n	<p>1991년 10월 22일 경기대학교 수원본교에 전자계산학과 야간 신설</p>\n	</li>\n	<li>\n	<p>1992년 7월 28일 대학원 석사과정에 전자계산학과 신설</p>\n	</li>\n	<li>\n	<p>1995년 10월 18일 대학원 박사과정에 전자계산학과 신설</p>\n	</li>\n	<li>\n	<p>1997년 11월 5일 대학원 박사과정에 전자계산학과 신설</p>\n	</li>\n	<li>\n	<p>2003년 5월 전자계산학과에서 컴퓨터과학과로 전공 명칭 변경</p>\n	</li>\n	<li>\n	<p>2007년 3월 공학인증 시작</p>\n	</li>\n	<li>\n	<p>2017년 3월 이공대학 컴퓨터과학과로 소속 변경</p>\n	</li>\n	<li>\n	<p>2018년 3월 융합과학대학 컴퓨터공학부로 소속 변경 (신입생 정원 150명)</p>\n	</li>\n</ul>\n'),(13,'ai','<p>컴퓨터과학과는 최고수준의 개인용 컴퓨터와 프로젝터 환경을 갖춘 4개의 실습실을 보유하고 있으며, 반 이상의 수업이 실습실에서 진행됩니다. 또한 팀프로젝트 진행을 위한 회의 공간과 세미나실을 제공하여 활발한 커뮤니케이션을 통한 창의적 인재를 양성하는데 힘을 쏟고 있습니다.</p>\n\n<ul>\n	<li>\n	<p>▶ 학과전용 실습실 현황</p>\n	</li>\n</ul>\n\n<p>&nbsp;</p>\n\n<table>\n	<colgroup>\n		<col />\n		<col />\n		<col />\n		<col />\n		<col />\n	</colgroup>\n	<tbody>\n		<tr>\n			<th>번호</th>\n			<th>호실</th>\n			<th>위치</th>\n			<th>PC대수</th>\n			<th>기타</th>\n		</tr>\n		<tr>\n			<td>1</td>\n			<td>8510</td>\n			<td>8강의동 5층</td>\n			<td>40</td>\n			<td>&nbsp;</td>\n		</tr>\n		<tr>\n			<td>2</td>\n			<td>8001</td>\n			<td>8강의동 B1층</td>\n			<td>45</td>\n			<td>&nbsp;</td>\n		</tr>\n		<tr>\n			<td>3</td>\n			<td>8308</td>\n			<td>8강의동 3층</td>\n			<td>50</td>\n			<td>야간 개방</td>\n		</tr>\n		<tr>\n			<td>4</td>\n			<td>8504</td>\n			<td>8강의동 5층</td>\n			<td>25</td>\n			<td>개방 실습실</td>\n		</tr>\n	</tbody>\n</table>\n\n<p>&nbsp;</p>\n\n<hr />\n<p><img height=\"300\" src=\"http://ai.kyonggi.ac.kr:8080/webp/img/8001.png\" width=\"500\" /></p>\n\n<p><img height=\"300\" src=\"http://ai.kyonggi.ac.kr:8080/webp/img/8308.png\" width=\"500\" /></p>\n\n<p><img height=\"300\" src=\"http://ai.kyonggi.ac.kr:8080/webp/img/8504.png\" width=\"500\" /></p>\n\n<hr />\n<ul>\n	<li>\n	<p>▶ 기타 실습환경</p>\n	</li>\n</ul>\n\n<p>교육과 연구를 위한 학과의 컴퓨팅 환경으로는 학과 공용으로 다수의 컴퓨터 서버, 스토리지 서버, 클러스터드 리눅스 서버를 갖추고 있으며, 연구실 별로도 각종 서버급 컴퓨터, 워크스테이션, 최신의 퍼스널 컴퓨터 및 여러 종류의 주변 기기를 보유하고 있습니다. 모든 컴퓨터는 초고속 통신망으로 인터넷에 연결되어 있으며 8강의동 전체에 무선랜이 설치되어 연구실과 강의실 어느 곳에서도 무선으로 인터넷 접속이 가능하도록 되어있습니다.</p>\n'),(13,'cs','<p>컴퓨터공학전공(컴퓨터공학부)은&nbsp;최고수준의 개인용 컴퓨터와 프로젝터 환경을 갖춘 4개의 실습실을 보유하고 있으며, 반 이상의 수업이 실습실에서 진행됩니다. 또한 팀프로젝트 진행을 위한 회의 공간과 세미나실을 제공하여 활발한 커뮤니케이션을 통한 창의적 인재를 양성하는데 힘을 쏟고 있습니다.</p>\n\n<ul>\n	<li>\n	<p>▶ 학과전용 실습실 현황</p>\n	</li>\n</ul>\n\n<p>\n<style type=\"text/css\">.tg {\n	border-collapse: collapse;\n	border-spacing: 0;\n}\n\n.tg td {\n	font-size: 14px;\n	padding: 10px 5px;\n	border-style: solid;\n	border-width: 1px;\n	overflow: hidden;\n	word-break: normal;\n}\n\n.tg th {;\n	font-size: 14px;\n	font-weight: normal;\n	padding: 10px 5px;\n	border-style: solid;\n	border-width: 1px;\n	overflow: hidden;\n	word-break: normal;\n}\n\n.tg .tg-s6z2 {\n	text-align: center\n}\n\n.tg .tg-baqh {\n	text-align: center;\n	vertical-align: top\n}\n\n.tg .tg-j4kc {\n	background-color: #efefef;\n	text-align: center\n}\n</style>\n</p>\n\n<table>\n	<colgroup>\n		<col />\n		<col />\n		<col />\n		<col />\n		<col />\n	</colgroup>\n	<tbody>\n		<tr>\n			<th>번호</th>\n			<th>호실</th>\n			<th>위치</th>\n			<th>PC대수</th>\n			<th>기타</th>\n		</tr>\n		<tr>\n			<td>1</td>\n			<td>8308</td>\n			<td>8강의동 3층</td>\n			<td>50</td>\n			<td>야간 개방</td>\n		</tr>\n		<tr>\n			<td>2</td>\n			<td>8001</td>\n			<td>8강의동 B1층</td>\n			<td>45</td>\n			<td>&nbsp;</td>\n		</tr>\n		<tr>\n			<td>3</td>\n			<td>8510</td>\n			<td>8강의동 5층</td>\n			<td>40</td>\n			<td>&nbsp;</td>\n		</tr>\n		<tr>\n			<td>4</td>\n			<td>8504</td>\n			<td>8강의동 5층</td>\n			<td>25</td>\n			<td>개방 실습실</td>\n		</tr>\n	</tbody>\n</table>\n\n<hr />\n<p><img height=\"300\" src=\"img/8001.png\" width=\"500\" /></p>\n\n<p><img height=\"300\" src=\"img/8308.png\" width=\"500\" /></p>\n\n<p><img height=\"300\" src=\"img/8504.png\" width=\"500\" /></p>\n\n<hr />\n<ul>\n	<li>\n	<p>▶ 기타 실습환경</p>\n	</li>\n</ul>\n\n<p>교육과 연구를 위한 학과의 컴퓨팅 환경으로는 학과 공용으로 다수의 컴퓨터 서버, 스토리지 서버, 클러스터드 리눅스 서버를 갖추고 있으며, 연구실 별로도 각종 서버급 컴퓨터, 워크스테이션, 최신의 퍼스널 컴퓨터 및 여러 종류의 주변 기기를 보유하고 있습니다. 모든 컴퓨터는 초고속 통신망으로 인터넷에 연결되어 있으며 8강의동 전체에 무선랜이 설치되어 연구실과 강의실 어느 곳에서도 무선으로 인터넷 접속이 가능하도록 되어있습니다.</p>\n'),(14,'ai','<p>- AI 시스템 개발에 필요한 기초 소프트웨어 지식 습득<br />\n- 체계적인 AI 시스템 모델링 및 설계 능력 함양<br />\n- 다양한 AI 응용산업별 AI기술 활용 능력 배양<br />\n- 소통과 문제 해결 능력을갖춘 실무형 AI 전문 인력 양성</p>\n\n<hr />\n<p>&nbsp;</p>\n'),(14,'cs','<p>1) 수요 지향적 융&middot;복합형 소프트웨어 엔지니어 양성</p>\n\n<p>- 컴퓨터 과학의 기본개념과 구성원리 이해<br />\n- 프로그래밍 능력과 도구의 활용 능력<br />\n- 수요지향적 기술의 습득과 실무능력 향상<br />\n- 다양한 분야와의 융&middot;복합을 통한 새로운 소프트웨어 지식 창출</p>\n\n<hr />\n<p>2) 국제적 경쟁력을 갖춘 글로벌 우수 인재 양성</p>\n\n<p>- 국제적인 수준의 프로그래밍 능력<br />\n- 국제적인 IT 관련 표준과 용어의 이해<br />\n- 국제적 표준을 이용한 설계 및 기술적 표현 능력 향상</p>\n\n<hr />\n<p>3) 자기 주도적 실용 IT 전문가 양성</p>\n\n<p>- 문제해결 능력과 설계능력의 함양<br />\n- 자기주도적 프로젝트 기획/설계/구현 능력<br />\n- 팀 단위의 작업을 통한 팀위크와 리더십의 훈련<br />\n- 발표능력과 문서작성 능력의 향상</p>\n\n<hr />'),(21,'ai','<p>인공지능학과에서는 인공지능 기술의 기본이 되는 논리적 기초와 컴퓨터 시스템의 동작 원리를 학습하고 파이썬 등 프로그램을 개발하는 능력을 습득, 훈련한다. 고학년에서는 실용적인 인공지능 기술 개발을 위한 빅데이터분산처리, 데이터마이닝, 기계학습과 딥러닝 등 응용 분야 기술을 습득한다. 4년 교육과정에서 모든 학생들이 5개 이상의 과목 프로젝트를 수행하여 다양한 분야의 설계와 개발을 경험한다. 그리고 전공 교육과정 전체를 이용한 캡스톤 프로젝트 개발과 현장실습교육을 통한 실무적인 능력을 습득한다.</p>\n'),(21,'cs','<p>컴퓨터공학전공(컴퓨터공학부)에서는 컴퓨터 기술의 기본이 되는 논리적 기초와 컴퓨터 시스템의 동작 원리를 학습하고 C, Java, 파이썬 등 프로그램을 개발하는 능력을 습득, 훈련한다. 고학년에서는 논리적이고 체계적인 사고를 이용한 인공지능, 데이터베이스, 멀티미디어, 소프트웨어공학 등 응용 분야 기술의 습득한다. 4년 교육과정에서 모든 학생들이 5개 이상의 과목 프로젝트를 수행하여 다양한 분야의 설계와 개발을 경험한다. 그리고 전공 교육과정 전체를 이용한 캡스톤 프로젝트 개발과 현장실습교육을 통한 실무적인 능력을 습득한다.</p>\n'),(22,'ai','<p>실습실 야간개방 및 프로그래밍 QnA 운영</p>\n\n<ul>\n	<li>학과에서는 8308호 실습실의 야간 (17:00-22:00) 시간에 개방하여 운영하고 있습니다.<br />\n	학생들의 과제와 학습을 위해 근무자 배치하여 운영하고 있으며,2017년 2학기부터는 프로그래밍 QnA 형태로 간단한 과제 지원 등을 함께 할 예정입니다.</li>\n</ul>\n\n<hr />\n<p>8504호 실습실 개방 운영</p>\n\n<ul>\n	<li>재학생들의 프로그래밍 과제와 학습을 위해 8504호 실습실을 주간 시간에 개방하여 운영하고 있습니다. 이 실습실은 수업 배정 없이 운영되며, 2017년 여름에 환경 개선 및 PC 교체로 우수한 환경을 구축하였습니다. 이외에 컴퓨터과학과에서는 다양한 학습활동 지원 프로그램을 운영하고 있습니다. 학과 홈페이지의 공지사항과 신청및접수 기능을 이용하여 참여하실 수 있습니다.</li>\n</ul>\n\n<hr />\n<ul>\n	<li>\n	<p>피어튜터링 [비교과프로그램]</p>\n	- MSC 및 전공과목을 주제<br />\n	- 튜터와 3인 이상 튜티로 구성된 팀으로 학기중 10회 이상 튜터링 학습 활동 진행<br />\n	- 튜터 장학금 및 참가자 KGU 포인트 지급<br />\n	- 공학인증지원센터 주관</li>\n</ul>\n\n<hr />\n<ul>\n	<li>\n	<p>KCPC 프로그래밍경진대회</p>\n	- 컴퓨터과학과에서는 매년 11월 재학생 대상으로 대회 개최<br />\n	- 2017년부터는 5월말에 1학년 대상의 C, 2학년 대상의 자바 프로그래밍 경진대회 개최<br />\n	- 2시간 가량 대회 진행, 시상</li>\n</ul>\n\n<hr />\n<ul>\n	<li>\n	<p>캡스톤설계전시회</p>\n	- 4학년 1학기 캡스톤설계 교과목 결과물의 전시회 개최 (매년 5월말)<br />\n	- 팀별로 개발된 캡스톤설계 프로젝트를 시연과 포스터로 전시함</li>\n</ul>\n\n<hr />\n<ul>\n	<li>\n	<p>우수학생작품발표회</p>\n	- 재학생(고학년 중심)의 우수한 작품을 한자리에 모아 발표하는 자리로 매년 11월 개최<br />\n	- 동아리, 팀활동, 교과목 프로젝트 등을 대상으로 심사하여 발표자 선정</li>\n</ul>\n\n<hr />\n<ul>\n	<li>\n	<p>방학집중캠프</p>\n	- 하계 및 동계 방학 기간에 5일 40시간의 집중 캠프를 진행<br />\n	- 프로그래밍 연습과 훈련을 위한 프로그래밍 캠프<br />\n	- IoT, 앱/웹 개발 등 실무 기술 교육 캠프<br />\n	- 방학 초 또는 개학 전 시기에 모집하여 진행<br />\n	- 2015~2017년 8회 진행 (교내 특성화 프로그램)</li>\n</ul>\n\n<hr />\n<ul>\n	<li>\n	<p>리터니캠프</p>\n	- 복학생 대상의 학업적응 지원 프로그램<br />\n	- 개학 전 시기에 복학생 대상으로 수강신청 안내, 수업 준비, 프로그래밍 교육 등 프로그램 운영<br />\n	- 2017년 2월 첫 시행</li>\n</ul>\n\n<hr />\n<ul>\n	<li>\n	<p>자격증준비반 (SQLD, ADsP)</p>\n	- 학기말 년 2회로 SQLD 자격증 준비반 프로그램 진행<br />\n	- 3,4학년 대상<br />\n	- 2015, 2016년 5회 운영</li>\n</ul>\n\n<hr />\n<p>&nbsp;</p>\n'),(22,'cs','<p>실습실 야간개방 및 프로그래밍 QnA 운영</p>\n\n<ul>\n	<li>학과에서는 8308호 실습실의 야간 (17:00-22:00) 시간에 개방하여 운영하고 있습니다.<br />\n	학생들의 과제와 학습을 위해 근무자 배치하여 운영하고 있으며,2017년 2학기부터는 프로그래밍 QnA 형태로 간단한 과제 지원 등을 함께 할 예정입니다.</li>\n</ul>\n\n<hr />\n<p>8504호 실습실 개방 운영</p>\n\n<ul>\n	<li>재학생들의 프로그래밍 과제와 학습을 위해 8504호 실습실을 주간 시간에 개방하여 운영하고 있습니다. 이 실습실은 수업 배정 없이 운영되며, 2017년 여름에 환경 개선 및 PC 교체로 우수한 환경을 구축하였습니다. 이외에 컴퓨터과학과에서는 다양한 학습활동 지원 프로그램을 운영하고 있습니다. 학과 홈페이지의 공지사항과 신청및접수 기능을 이용하여 참여하실 수 있습니다.</li>\n</ul>\n\n<hr />\n<ul>\n	<li>\n	<p>피어튜터링 [비교과프로그램]</p>\n	- MSC 및 전공과목을 주제<br />\n	- 튜터와 3인 이상 튜티로 구성된 팀으로 학기중 10회 이상 튜터링 학습 활동 진행<br />\n	- 튜터 장학금 및 참가자 KGU 포인트 지급<br />\n	- 공학인증지원센터 주관</li>\n</ul>\n\n<hr />\n<ul>\n	<li>\n	<p>KCPC 프로그래밍경진대회</p>\n	- 컴퓨터과학과에서는 매년 11월 재학생 대상으로 대회 개최<br />\n	- 2017년부터는 5월말에 1학년 대상의 C, 2학년 대상의 자바 프로그래밍 경진대회 개최<br />\n	- 2시간 가량 대회 진행, 시상</li>\n</ul>\n\n<hr />\n<ul>\n	<li>\n	<p>캡스톤설계전시회</p>\n	- 4학년 1학기 캡스톤설계 교과목 결과물의 전시회 개최 (매년 5월말)<br />\n	- 팀별로 개발된 캡스톤설계 프로젝트를 시연과 포스터로 전시함</li>\n</ul>\n\n<hr />\n<ul>\n	<li>\n	<p>우수학생작품발표회</p>\n	- 재학생(고학년 중심)의 우수한 작품을 한자리에 모아 발표하는 자리로 매년 11월 개최<br />\n	- 동아리, 팀활동, 교과목 프로젝트 등을 대상으로 심사하여 발표자 선정</li>\n</ul>\n\n<hr />\n<ul>\n	<li>\n	<p>방학집중캠프</p>\n	- 하계 및 동계 방학 기간에 5일 40시간의 집중 캠프를 진행<br />\n	- 프로그래밍 연습과 훈련을 위한 프로그래밍 캠프<br />\n	- IoT, 앱/웹 개발 등 실무 기술 교육 캠프<br />\n	- 방학 초 또는 개학 전 시기에 모집하여 진행<br />\n	- 2015~2017년 8회 진행 (교내 특성화 프로그램)</li>\n</ul>\n\n<hr />\n<ul>\n	<li>\n	<p>리터니캠프</p>\n	- 복학생 대상의 학업적응 지원 프로그램<br />\n	- 개학 전 시기에 복학생 대상으로 수강신청 안내, 수업 준비, 프로그래밍 교육 등 프로그램 운영<br />\n	- 2017년 2월 첫 시행</li>\n</ul>\n\n<hr />\n<ul>\n	<li>\n	<p>자격증준비반 (SQLD, ADsP)</p>\n	- 학기말 년 2회로 SQLD 자격증 준비반 프로그램 진행<br />\n	- 3,4학년 대상<br />\n	- 2015, 2016년 5회 운영</li>\n</ul>\n\n<hr />\n<p>&nbsp;</p>\n'),(23,'ai','ai 23'),(23,'cs','cs 23'),(31,'ai','ai 31'),(31,'cs','cs 31'),(32,'ai','ai 32'),(32,'cs','cs 32');
/*!40000 ALTER TABLE `v2_text` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `webzine_boards`
--

    DROP TABLE IF EXISTS `webzine_boards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `webzine_boards` (
    `id` smallint unsigned NOT NULL AUTO_INCREMENT,
    `student_id` varchar(50) NOT NULL,
    `title` varchar(250) NOT NULL DEFAULT '제목없음',
    `category` varchar(20) DEFAULT NULL,
    `views` smallint unsigned NOT NULL DEFAULT '0',
    `likes` smallint unsigned NOT NULL DEFAULT '0',
    `level` tinyint NOT NULL DEFAULT '0',
    `currentStatus` tinyint NOT NULL DEFAULT '0',
    `last_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `content` text NOT NULL,
    `student_name` varchar(45) NOT NULL,
    `comments_count` int NOT NULL DEFAULT '0',
    `already_like` varchar(3000) NOT NULL DEFAULT '',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webzine_boards`
--

    LOCK TABLES `webzine_boards` WRITE;
/*!40000 ALTER TABLE `webzine_boards` DISABLE KEYS */;
/*!40000 ALTER TABLE `webzine_boards` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `webzine_comments`
--

    DROP TABLE IF EXISTS `webzine_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `webzine_comments` (
    `id` smallint unsigned NOT NULL AUTO_INCREMENT,
    `writer_id` varchar(50) NOT NULL,
    `writer_name` varchar(45) NOT NULL,
    `article_id` smallint unsigned NOT NULL,
    `last_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `content` varchar(225) NOT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webzine_comments`
--

    LOCK TABLES `webzine_comments` WRITE;
/*!40000 ALTER TABLE `webzine_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `webzine_comments` ENABLE KEYS */;
    UNLOCK TABLES;

--
-- Table structure for table `webzine_file`
--

    DROP TABLE IF EXISTS `webzine_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
    CREATE TABLE `webzine_file` (
    `board_id` int NOT NULL DEFAULT '0',
    `filename` varchar(90) NOT NULL,
    `filelink` varchar(90) NOT NULL,
    `id` varchar(100) NOT NULL,
    `writer` varchar(45) DEFAULT '0',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webzine_file`
--

    LOCK TABLES `webzine_file` WRITE;
/*!40000 ALTER TABLE `webzine_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `webzine_file` ENABLE KEYS */;
    UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-27 13:35:10

-- 이건 서버에 이미 반영한 것이지만 아직 여기에는 반영이 안된거라 위로 빼놓음
DELETE FROM `fdb_pages` WHERE id=100;
-- 서버에 이미 있으니깐 무시



-- 여기서 부터 서버 DB로 업데이트
UPDATE `fdb_pages` SET path='laboratory.kgu' WHERE id=27;
UPDATE `fdb_pages` SET path='professor.kgu' WHERE id=28;
UPDATE `fdb_pages` SET path='notice_article_list.kgu' WHERE id=29;
UPDATE `fdb_pages` SET path='notice_article_list.kgu' WHERE id=41;
UPDATE `fdb_pages` SET path='notice_article_list.kgu' WHERE id=46;
UPDATE `fdb_pages` SET path='notice_article_list.kgu' WHERE id=51;

-- locker 업데이트
delete from kgcs.fdb_pages where id = 106;
delete from kgcs.fdb_pages where id = 107;
delete from kgcs.fdb_pages where id = 108;
delete from kgcs.fdb_pages where id = 109;
delete from kgcs.fdb_pages where id = 110;
delete from kgcs.fdb_pages where id = 111;
delete from kgcs.fdb_pages where id = 112;

update kgcs.fdb_pages set path = 'admin.kgu' where id= 63;
update kgcs.fdb_pages set path = 'admin.kgu' where id= 64;
update kgcs.fdb_pages set path = 'admin.kgu' where id= 65;
update kgcs.fdb_pages set path = 'admin.kgu' where id= 66;
update kgcs.fdb_pages set path = 'admin.kgu' where id= 79;
update kgcs.fdb_pages set path = 'admin.kgu' where id= 80;
update kgcs.fdb_pages set path = 'admin.kgu' where id= 91;

update kgcs.fdb_pages set path = 'locker_apply.kgu' where id= 93;
update kgcs.fdb_pages set path = 'locker_apply_list.kgu' where id= 97;
update kgcs.fdb_pages set path = 'locker_assigned_list.kgu' where id= 98;
update kgcs.fdb_pages set path = 'locker_manager.kgu' where id= 96;
update kgcs.fdb_pages set path = 'locker_schedule.kgu' where id= 92;
update kgcs.fdb_pages set path = 'locker_schedule.kgu' where id= 95;
update kgcs.fdb_pages set path = 'locker_schedule.kgu?num=111' where id= 88;



-- 여기서부터 사용
update kgcs.fdb_pages set path='req_article_list.kgu' where id=31;
update kgcs.fdb_pages set path ='notice_article_list.kgu?num=91' where id=78;
update kgcs.fdb_pages set path ='notice_article_list.kgu' where id=81;

update kgcs.fdb_pages set path='webzine_list.kgu' where id=72;
update kgcs.fdb_pages set path ='webzine_list.kgu?' where id=73;
update kgcs.fdb_pages set path ='webzine_list.kgu' where id=74;


